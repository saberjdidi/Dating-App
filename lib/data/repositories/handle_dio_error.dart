import 'package:dio/dio.dart';

class HandleDioError {

static String handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout || e.type == DioExceptionType.sendTimeout) {
      return 'Connection timeout. Vérifie ta connexion.';
    }
    if (e.response != null && e.response?.data != null) {
      try {
        final body = e.response!.data;
        if (body is Map<String, dynamic> && body['message'] != null) return body['message'].toString();
        return body.toString();
      } catch (_) {
        return e.response.toString();
      }
    }
    return e.message!;
  }
}