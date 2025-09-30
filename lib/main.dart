import 'package:dating_app_bilhalal/core/utils/initial_bindings.dart';
import 'package:dating_app_bilhalal/routes/app_routes.dart';
import 'package:dating_app_bilhalal/presentation/splash_screen/controller/splash_redirect_controller.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_export.dart';

void main() async  {
  ///WidgetsFlutterBinding.ensureInitialized();
  ///Add Widgets Binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Garde le splash natif jusqu'à la fin de l'initialisation
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialise SharedPreferences AVANT de construire l'app
  await PrefUtils.init();
  /* await SharedPreferences.getInstance().then((prefs) {
    PrefUtils.sharedPreferences = prefs;
  }); */

  //Get.put(SplashRedirectController()); //using when use flutter_native_splash

  runApp(const MyApp());
  // Supprime le splash après que l'app soit prête
  //FlutterNativeSplash.remove();
  //For testing preview device
 /* DevicePreview(
    //enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ); */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //locale: DevicePreview.locale(context), //For testing preview device
      //builder: DevicePreview.appBuilder, //For testing preview device
      theme: ThemeHelper().getCurrentTheme(),
      //translations: AppLocalization(),
      //locale: translationController.language,
      title: 'بالحلال',
      initialBinding: InitialBindings(),
      //home: const Scaffold(backgroundColor: TColors.yellowAppDark, body: Center(child: CircularProgressIndicator(color: TColors.white,),),),
      //home: const SplashRedirect(), // On commence par la redirection
      initialRoute: Routes.initialRoute, //utilise si on utilise splashscreen/splashcontroller
      getPages: AppRoutes.pages,
     /* builder: (context, child) {
        return MyAppWithDeepLinkHandling(child: child, initialUri: initialUri);
      }, */
    );
  }
}


