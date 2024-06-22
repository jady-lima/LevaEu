import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient({required String baseUrl, required String apiKey})
      : dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          queryParameters: {
            'key': apiKey,
          },
        ));

  Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    final response = await dio.get(endpoint, queryParameters: queryParameters);
    return response;
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    final response = await dio.post(endpoint, data: data);
    return response;
  }
}
