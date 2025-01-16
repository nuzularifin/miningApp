import 'package:dio/dio.dart';
import 'package:flutter_test_synapsys/utils/logging_interceptor.dart';

class BaseApiService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://dev-api-fms.apps-madhani.com/v1';

  BaseApiService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(LoggingInterceptor());
  }

  Dio get dio => _dio;
  String get baseUrl => _baseUrl;
}
