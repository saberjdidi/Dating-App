class ApiConstants {
  // Base URL centralisée
  static const String baseUrl = 'http://164.92.138.66/api/v1/app/';

  //Authentication
  static const String authRegister = 'auth/register';
  static const String authLogin = 'auth/login';
  static const String authForgetPassword = 'auth/forgot-password';
  static const String authResetPassword = 'auth/reset-password';

  //OTP
  static const String verifyOtp = 'auth/verify-otp';
  static const String resendOtp = 'auth/resend-otp';

  //User
  static const String user = 'user';
  static const String searchUser = 'search/users';

  //Profile
  static const String profileReport = 'reports';
  static const String hobbies = 'hobbies';

  //Media
  static const String media = 'media';

  //Media
  static const String support = 'support/messages';

  //Media
  static const String favourites = 'favourites';
}

class HttpStatusCode {
  static const int ok = 200;
  static const int created = 201;
  static const int unauthorized = 401;
  static const int badRequest = 400;
  static const int internalServerError = 500;
}