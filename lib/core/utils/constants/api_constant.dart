class ApiConstants {
  // Base URL centralisée
  static const String baseUrl = 'http://164.92.138.66/api/v1/app/';

  // Endpoints (relatif à baseUrl)
  static const String authRegister = 'auth/register';
  static const String authLogin = 'auth/login';

  static const String verifyOtp = 'auth/verify-otp';
  static const String resendOtp = 'auth/resend-otp';
// ajouter les autres endpoints ici...
}

class HttpStatusCode {
  static const int ok = 200;
  static const int created = 201;
  static const int unauthorized = 401;
  static const int badRequest = 400;
  static const int internalServerError = 500;
}