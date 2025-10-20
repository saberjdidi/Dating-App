import 'package:dating_app_bilhalal/core/utils/initial_bindings.dart';
import 'package:dating_app_bilhalal/data/repositories/authentication_repository.dart';
import 'package:dating_app_bilhalal/firebase_options.dart';
import 'package:dating_app_bilhalal/localization/app_localization.dart';
import 'package:dating_app_bilhalal/localization/translation_controller.dart';
import 'package:dating_app_bilhalal/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_export.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  ///Add Widgets Binding
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Garde le splash natif jusqu'à la fin de l'initialisation
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialise SharedPreferences AVANT de construire l'app
  await PrefUtils.init();
  //await GetStorage.init();

  /// Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
        (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  // Active le mode immersif total
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); //works for nidhal
  ///SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []); works but status black on top

  // Mode immersif sticky : cache les barres et gère les gestes pour les réafficher temporairement
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    //SystemUiMode.immersiveSticky, //SystemUiMode.edgeToEdge,
    overlays: [], // Cache status bar ET navigation bar
  );
  // Force la transparence + visibilité des icônes
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // rend la status bar transparente
    systemNavigationBarColor: Colors.transparent, // rend aussi la barre du bas transparente
      //statusBarBrightness: Brightness.light, // Icônes sombres si fond clair (ajustez si thème sombre)
      //statusBarIconBrightness: Brightness.dark, // Icônes visibles
    ),
  );

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
    TranslationController translationController = Get.put(TranslationController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //locale: DevicePreview.locale(context), //For testing preview device
      //builder: DevicePreview.appBuilder, //For testing preview device
      theme: ThemeHelper().getCurrentTheme(),
      translations: AppLocalization(),
      locale: translationController.language,
      title: 'بالحلال',
      initialBinding: InitialBindings(),
      initialRoute: Routes.initialRoute,
      getPages: AppRoutes.pages,
    );
  }
}


