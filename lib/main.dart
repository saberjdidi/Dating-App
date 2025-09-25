import 'package:dating_app_bilhalal/core/utils/initial_bindings.dart';
import 'package:dating_app_bilhalal/routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'core/app_export.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
      initialRoute: Routes.initialRoute,
      getPages: AppRoutes.pages,
     /* builder: (context, child) {
        return MyAppWithDeepLinkHandling(child: child, initialUri: initialUri);
      }, */
    );
  }
}

