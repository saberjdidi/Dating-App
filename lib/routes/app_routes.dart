import 'package:dating_app_bilhalal/presentation/account_screen/binding/account_binding.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/create_account_screen.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/overview_account_screen.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/success_account_screen.dart';
import 'package:dating_app_bilhalal/presentation/account_screen/welcome_screen.dart';
import 'package:dating_app_bilhalal/presentation/discussion_screen/binding/discussion_binding.dart';
import 'package:dating_app_bilhalal/presentation/discussion_screen/discusion_details_screen.dart';
import 'package:dating_app_bilhalal/presentation/discussion_screen/discussion_screen.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/binding/filter_binding.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/filter_screen.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/binding/main_binding.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/main_screen.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/binding/navigation_binding.dart';
import 'package:dating_app_bilhalal/presentation/navigation_screen/navigation_screen.dart';
import 'package:dating_app_bilhalal/presentation/onboarding_screen/binding/onboarding_binding.dart';
import 'package:dating_app_bilhalal/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/binding/profile_binding.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/profile_details_screen.dart';
import 'package:dating_app_bilhalal/presentation/sign_in_screen/binding/sign_in_binding.dart';
import 'package:dating_app_bilhalal/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:dating_app_bilhalal/presentation/signup_screen/binding/signup_binding.dart';
import 'package:dating_app_bilhalal/presentation/signup_screen/signup_screen.dart';
import 'package:dating_app_bilhalal/presentation/signup_screen/signup_with_email_screen.dart';
import 'package:dating_app_bilhalal/presentation/splash_screen/binding/splash_binding.dart';
import 'package:dating_app_bilhalal/presentation/splash_screen/splash_screen.dart';

import '../core/app_export.dart';

class AppRoutes {

  static List<GetPage> pages = [

  GetPage(
  name: Routes.splashScreen,
  page: () => const SplashScreen(),
  bindings: [
    SplashBinding(),
  ]),
    GetPage(
      name: Routes.initialRoute,
      page: () => const SplashScreen(),
      bindings: [
        SplashBinding(),
      ],
    ),
    GetPage(
      name: Routes.onboardingScreen,
      page: () => const OnBoardingScreen(),
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
      name: Routes.discussionScreen,
      page: () => DiscussionScreen(),
      bindings: [
        DiscussionBinding(),
      ],
    ),
    GetPage(
      name: Routes.discussionDetailsScreen,
      page: () => DiscussionDetailsScreen(),
      bindings: [
        DiscussionBinding(),
      ],
    ),
    GetPage(
      name: Routes.profileDetailsScreen,
      page: () => ProfileDetailsScreen(),
      bindings: [
        ProfileBinding(),
      ],
    ),
    /*
    GetPage(
      name: Routes.onboardingScreen1,
      page: () => OnboardingScreen1(),
      bindings: [
        OnboardingBinding(),
      ],
    ),
    GetPage(
      name: Routes.signUpStepperScreen,
      page: () => SignUpStepperScreen(),
      bindings: [
        SignupStepperBinding(),
      ],
    ),
    GetPage(
      name: Routes.forgotPasswordScreen,
      page: () => ForgotPasswordScreen(),
      bindings: [
        ForgotPasswordBinding(),
      ],
    ),
    GetPage(
      name: Routes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
      bindings: [
        ForgotPasswordBinding(),
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
      name: Routes.homeScreen,
      page: () => HomeScreen(),
      bindings: [
        NavigationBinding(),
        //HomeBinding(),
      ],
    ),
   */
  ];
}