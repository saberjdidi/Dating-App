import 'package:dating_app_bilhalal/presentation/onboarding_screen/binding/onboarding_binding.dart';
import 'package:dating_app_bilhalal/presentation/onboarding_screen/onboarding_screen.dart';
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
    /*
    GetPage(
      name: Routes.onboardingScreen1,
      page: () => OnboardingScreen1(),
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