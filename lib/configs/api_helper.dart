import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:unlimit_demo/configs/app_constants.dart';
import 'package:unlimit_demo/configs/flavor.dart';
import 'package:unlimit_demo/configs/logging_utils.dart';
import 'package:unlimit_demo/data/remote/api_response_model.dart';
import 'package:unlimit_demo/res/strings/strings.dart';

enum ApiType { get, post, put, delete }

class ApiHelper {
  static final ApiHelper instance = ApiHelper.init();
  static const _tag = 'API_HELPER';

  factory ApiHelper() => instance;

  var dio = Dio();

  ApiHelper.init() {
    onInit();
  }

  @override
  void onInit() {
    dio.options.baseUrl = '';
    dio.options.connectTimeout = AppConstants.apiTimeout;
    dio.options.receiveTimeout = AppConstants.apiTimeout;
    dio.interceptors.add(PrettyDioLogger());
  }

  /// set default headers
  Future<Map<String, String>?> getDeFaultHeaders(
      {bool? isContentTypeJson = true}) async {
    Map<String, String> headers = {};

    if (isContentTypeJson!) {
      headers['Accept'] = 'application/json, text/plain';
    }
    return headers;
  }

  /// function to connect with server
  /// [apiType] is the request type
  /// [header] is attached with the request
  /// [query] parameter attached with [ApiType.get] request
  /// [body] will attached with put and post request
  Future<ApiResponse> fetch(
    ApiType apiType, {
    required String route,
    Map<String, String>? header,
    Map<String, dynamic>? query,
    dynamic body,
  }) async {
    // Logging().logger.d("Api Hitting Type:- $apiType");

    final mHeader = header ?? await getDeFaultHeaders();
    final mUrl = Flavor.data['base_url'] + route;
    try {
      Response response = switch (apiType) {
        ApiType.get => await dio.get(
            mUrl,
            options: Options(
              validateStatus: (status) => true,
              headers: mHeader,
            ),
            queryParameters: query,
          ),
        ApiType.post => await dio.post(
            mUrl,
            data: body,
            options: Options(
              validateStatus: (status) => true,
              headers: mHeader,
            ),
          ),
        ApiType.put => await dio.put(
            mUrl,
            data: body,
            options: Options(
              validateStatus: (status) => true,
              headers: mHeader,
            ),
          ),
        ApiType.delete => await dio.delete(
            mUrl,
            options: Options(
              validateStatus: (status) => true,
              headers: mHeader,
            ),
          ),
        // _ => null,
      };
      return handleDioResponse(response);
    } on SocketException catch (ex) {
      debugPrint("SocketException $ex");
      return ApiResponse(false, errorMessage: Strings.noInternetMessage);
    } on TimeoutException catch (ex) {
      debugPrint("TimeoutException $ex");
      return ApiResponse(false, errorMessage: Strings.timeoutMessage);
    } on DioException catch (ex) {
      return dioUserMessage(ex);
    } catch (ex) {
      Logging().logger.t(_tag, error: ex);
      return ApiResponse(false, errorMessage: ex.toString());
    }
  }

  /// function to handle response according to status codes
  /// [response] is the response got from api
  Future<ApiResponse> handleDioResponse(Response response) async {
    if (response.statusCode == HttpStatus.ok) {
      return ApiResponse.fromJSON(response.data);
    } else if (response.statusCode == HttpStatus.notFound) {
      return ApiResponse(false, errorMessage: 'Error Please try again later');
    } else {
      if (response.statusCode == HttpStatus.unauthorized) {
        if (response.data is Map) {
          return ApiResponse(false,
              errorMessage: response.data['message'] ?? Strings.unAuthorized);
        } else {
          return ApiResponse(false, errorMessage: Strings.unAuthorized);
        }
      } else {
        String errorMessage = '';
        if (response.data == null) {
          errorMessage = Strings.noInternetMessage;
        } else {
          if (response.data is Map) {
            Map<dynamic, dynamic> body = response.data;
            if (body.containsKey('errors') && body['errors'] is List) {
              // handle if multiple error occures
              errorMessage = body['errors'].join('\n');
            } else {
              try {
                errorMessage = body['message'];
              } catch (e) {
                debugPrint('$e');
              }
            }
          } else {
            try {
              errorMessage = response.data.toString();
            } catch (e) {
              debugPrint('$e');
            }
          }
        }
        // customLog(_tag, message: "errorMessage $errorMessage");
        return ApiResponse(false, errorMessage: errorMessage);
      }
    }
  }
}

/// function to handle DioException and provide generic message
/// according to DioException [ex]
Future<ApiResponse> dioUserMessage(DioException ex) async {
  String errMessage = ex.message ?? '';
  if (ex.type == DioExceptionType.connectionTimeout ||
      ex.type == DioExceptionType.receiveTimeout) {
    return ApiResponse(false, errorMessage: Strings.timeoutMessage);
  } else if (ex.type == DioExceptionType.unknown) {
    if (ex.response?.statusCode == HttpStatus.notFound) {
      return ApiResponse(false, errorMessage: Strings.notFoundMessage);
    } else if (errMessage.contains("SocketException")) {
      return ApiResponse(false, errorMessage: Strings.noInternetMessage);
    }
    return ApiResponse(false, errorMessage: Strings.commonWrongMessage);
  } else {
    return ApiResponse(false, errorMessage: Strings.somethingWentWrong);
  }
}
