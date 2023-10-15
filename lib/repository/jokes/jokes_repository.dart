import 'package:unlimit_demo/configs/api_helper.dart';
import 'package:unlimit_demo/data/remote/api_response_model.dart';
import 'package:unlimit_demo/routes/api_routes.dart';

class JokesRepository {
  static final JokesRepository _jokesRepository = JokesRepository._();

  JokesRepository._();

  factory JokesRepository() {
    return _jokesRepository;
  }

  /// fetch jokes from server
  /// [query] is the query params to be added in request
  Future<ApiResponse> getJokes({
    Map<String, dynamic>? query,
  }) async {
    try {
      return await ApiHelper.instance
          .fetch(ApiType.get, route: ApiRoutes.apiJokes, query: query);
    } catch (e) {
      return ApiResponse(false, errorMessage: e.toString());
    }
  }
}
