class ApiConstants {
  // Base URL centralisée
  static const String baseUrl = 'http://164.92.138.66/api/v1/app/';

  //Authentication
  static const String authRegister = 'auth/register';
  static const String authLogin = 'auth/login';
  static const String authForgetPassword = 'auth/forgot-password';
  static const String authResetPassword = 'auth/reset-password';
  static const String changePassword = 'user/password';

  //OTP
  static const String verifyOtp = 'auth/verify-otp';
  static const String verifyResetOtp = 'auth/verify-reset-otp';
  static const String resendOtp = 'auth/resend-otp';

  //User
  static const String user = 'user';
  static const String searchUser = 'search/users';

  //Profile
  static const String profileReport = 'reports';
  //static const String hobbies = 'hobbies';

  //Media
  static const String media = 'media';

  //Media
  static const String support = 'support/messages';

  //Favorite
  static const String favourites = 'favourites';

  //Likes
  static const String likes = 'likes';

  //Settings
  static const String permissions = 'settings/call-permissions';

  //Presence
  static const String presence = 'presence';

  //Subscriptions
  static const String subscriptionPlans = 'subscriptions/plans';

  //Countries
  static const String countries = 'countries/localized';
}

class HttpStatusCode {
  static const int ok = 200;
  static const int created = 201;
  static const int unauthorized = 401;
  static const int badRequest = 400;
  static const int internalServerError = 500;
}