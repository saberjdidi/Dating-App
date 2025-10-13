import 'package:dating_app_bilhalal/presentation/account_screen/binding/account_binding.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/create_account_screen.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/overview_account_screen.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/success_account_screen.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/welcome_screen.dart';
import 'package:dating_app_bilhalal/presentation/call_screen/binding/call_binding.dart';
import 'package:dating_app_bilhalal/presentation/call_screen/call_screen.dart';
import 'package:dating_app_bilhalal/presentation/call_screen/call_video_screen.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/binding/discussion_binding.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/message_screen.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/chat_screen.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/chat_user_profile_screen.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/binding/favorite_binding.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/favorite_screen.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/binding/filter_binding.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/filter_screen.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/binding/main_binding.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/main_screen.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/binding/navigation_binding.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/navigation_screen.dart';
import 'package:dating_app_bilhalal/presentation/onboarding_screen/binding/onboarding_binding.dart';
import 'package:dating_app_bilhalal/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:dating_app_bilhalal/presentation/otp_screen/binding/otp_binding.dart';
import 'package:dating_app_bilhalal/presentation/otp_screen/otp_screen.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/binding/password_binding.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/change_password_screen.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/forget_password_screen.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/binding/profile_binding.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/media_owner_profile_screen.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/profile_details_screen.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/profile_screen.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/user_owner_profile_screen.dart';
import 'package:dating_app_bilhalal/presentation/settings_screen/binding/settings_binding.dart';
import 'package:dating_app_bilhalal/presentation/settings_screen/settings_screen.dart';
import 'package:dating_app_bilhalal/presentation/sign_in_screen/binding/sign_in_binding.dart';
import 'package:dating_app_bilhalal/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:dating_app_bilhalal/presentation/signup_screen/binding/signup_binding.dart';
import 'package:dating_app_bilhalal/presentation/signup_screen/signup_screen.dart';
import 'package:dating_app_bilhalal/presentation/signup_screen/signup_with_email_screen.dart';
import 'package:dating_app_bilhalal/presentation/splash_screen/binding/splash_binding.dart';
import 'package:dating_app_bilhalal/presentation/splash_screen/splash_screen.dart';
import 'package:dating_app_bilhalal/presentation/subscribe_screen/binding/subscribe_binding.dart';
import 'package:dating_app_bilhalal/presentation/subscribe_screen/subscribe_screen.dart';
import 'package:dating_app_bilhalal/presentation/subscribe_screen/update_subscribe_screen.dart';
import 'package:dating_app_bilhalal/presentation/support_screen/binding/support_binding.dart';
import 'package:dating_app_bilhalal/presentation/support_screen/support_screen.dart';

import '../core/app_export.dart';

class AppRoutes {

  static List<GetPage> pages = [

  GetPage(
  name: Routes.splashScreen,
  page: () => SplashScreen(),
  bindings: [
    SplashBinding(),
  ]),
    GetPage(
      name: Routes.initialRoute,
      page: () => SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: Routes.onboardingScreen,
      page: () => OnBoardingScreen(),
      bindings: [
        OnboardingBinding(),
      ],
    ),
    GetPage(
      name: Routes.signInScreen,
      page: () => SignInScreen(),
      bindings: [
        SignInBinding(),
      ],
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => SignUpScreen(),
      bindings: [
        SignUpBinding(),
      ],
    ),
    GetPage(
      name: Routes.signUpWithEmailScreen,
      page: () => SignUpWithEmailScreen(),
      bindings: [
        SignUpBinding(),
      ],
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => OTPScreen(),
      bindings: [
        OTPBinding(),
      ],
    ),
    GetPage(
      name: Routes.createAccountScreen,
      page: () => CreateAccountScreen(),
      bindings: [
        AccountBinding(),
      ],
    ),
    GetPage(
      name: Routes.overviewAccountScreen,
      page: () => OverviewAccountScreen(),
      bindings: [
        AccountBinding(),
      ],
    ),
    GetPage(
      name: Routes.successAccountScreen,
      page: () => SuccessAccountScreen(),
      bindings: [
        AccountBinding(),
      ],
    ),
    GetPage(
      name: Routes.welcomeScreen,
      page: () => WelcomeScreen(),
      bindings: [
        AccountBinding(),
      ],
    ),
    GetPage(
      name: Routes.navigationScreen,
      page: () => NavigationScreen(),
      bindings: [
        NavigationBinding(),
      ],
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => MainScreen(),
      bindings: [
        MainBinding(),
      ],
    ),
    GetPage(
      name: Routes.filterScreen,
      page: () => FilterScreen(),
      bindings: [
        FilterBinding(),
      ],
    ),
    GetPage(
      name: Routes.chatScreen,
      page: () => ChatScreen(),
      bindings: [
        DiscussionBinding(),
      ],
    ),
    GetPage(
      name: Routes.messageScreen,
      page: () => MessageScreen(),
      bindings: [
        DiscussionBinding(),
      ],
    ),
    GetPage(
      name: Routes.chatUserProfileScreen,
      page: () => ChatUserProfileScreen(),
      bindings: [
        DiscussionBinding(),
      ],
    ),
    GetPage(
      name: Routes.profileScreen,
      page: () => ProfileScreen(),
      bindings: [
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: Routes.profileDetailsScreen,
      page: () => ProfileDetailsScreen(),
      bindings: [
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: Routes.userOwnerProfileScreen,
      page: () => UserOwnerProfileScreen(),
      bindings: [
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: Routes.mediaOwnerProfileScreen,
      page: () => MediaOwnerProfileScreen(),
      bindings: [
        ProfileBinding(),
      ],
    ),
    GetPage(
      name: Routes.settingsScreen,
      page: () => SettingsScreen(),
      bindings: [
        SettingsBinding(),
      ],
    ),
    GetPage(
      name: Routes.favoriteScreen,
      page: () => FavoriteScreen(),
      bindings: [
        FavoriteBinding(),
      ],
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
      bindings: [
        PasswordBinding(),
      ],
    ),
    GetPage(
      name: Routes.forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      bindings: [
        PasswordBinding(),
      ],
    ),
    GetPage(
      name: Routes.subscribeScreen,
      page: () => SubscribeScreen(),
      bindings: [
        SubscribeBinding(),
      ],
    ),
    GetPage(
      name: Routes.updateSubscribeScreen,
      page: () => UpdateSubscribeScreen(),
      bindings: [
        SubscribeBinding(),
      ],
    ),
    GetPage(
      name: Routes.callScreen,
      page: () => CallScreen(),
      bindings: [
        CallBinding(),
      ],
    ),
    GetPage(
      name: Routes.callVideoScreen,
      page: () => CallVideoScreen(),
      bindings: [
        CallBinding(),
      ],
    ),
    GetPage(
      name: Routes.supportScreen,
      page: () => SupportScreen(),
      bindings: [
        SupportBinding(),
      ],
    ),
  ];
}