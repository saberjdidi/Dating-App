import 'package:dating_app_bilhalal/core/utils/logout.dart';
import 'package:dating_app_bilhalal/core/utils/message_snackbar.dart';
import 'package:dating_app_bilhalal/core/utils/pref_utils.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await PrefUtils.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Si le token est expiré → déconnexion automatique
      Logout.onTapLogout();
      //PrefUtils.clearToken();
      //Get.offAllNamed(Routes.signInScreen);
      MessageSnackBar.errorSnackBar(
        title: 'Session expirée',
        message: 'Veuillez vous reconnecter.',
      );
    }

    return handler.next(err);
  }
}
