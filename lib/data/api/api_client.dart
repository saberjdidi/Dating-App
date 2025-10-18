// lib/data/api/api_client.dart
import 'package:dating_app_bilhalal/core/utils/constants/api_constant.dart';
import 'package:dating_app_bilhalal/data/api/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;

  ApiClient._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    dio = Dio(options);

    // Logging interceptor (debug only)
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ));
    }

    // Auth interceptor global
    dio.interceptors.add(AuthInterceptor());
    // Optional: add token interceptor later
    // dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async { ... }));
  }

  //POST
  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) async {
    return await dio.post(path, data: data, queryParameters: queryParameters, options: options);
  }

  //GET
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    return await dio.get(path, queryParameters: queryParameters, options: options);
  }

// PUT
  Future<Response> put(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options}) async {
    return await dio.put(path,
        data: data, queryParameters: queryParameters, options: options);
  }

  // PATCH
  Future<Response> patch(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options}) async {
    return await dio.patch(path,
        data: data, queryParameters: queryParameters, options: options);
  }

  // DELETE
  Future<Response> delete(String path,
      {dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options}) async {
    return await dio.delete(path,
        data: data, queryParameters: queryParameters, options: options);
  }
}
