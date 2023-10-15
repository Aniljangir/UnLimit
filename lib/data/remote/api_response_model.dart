import 'package:flutter/foundation.dart';

class ApiResponse {
  @required
  bool status;
  dynamic data;
  dynamic errorMessage;
  dynamic message;

  ApiResponse(this.status, {this.data, this.errorMessage, this.message});

  factory ApiResponse.fromJSON(Map<String, dynamic> jsonObject) {
    return ApiResponse(true,
        data: jsonObject, errorMessage: '', message: 'fetched');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    data['data'] = this.data;
    data['errorMessage'] = errorMessage;
    data['message'] = message;
    return data;
  }
}
