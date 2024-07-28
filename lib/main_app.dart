import 'package:control_proctor/routes_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'bindings/bindings.dart';
import 'resource_manager/theme_manager.dart';

class MyApp extends StatefulWidget {
  static const MyApp _instance = MyApp._internal(); // singlton instance

  factory MyApp() => _instance;

  const MyApp._internal();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      title: 'NIS Control System',
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      theme: getApplicationTheme(),
      getPages: Routes.routes,
      initialBinding: InitialBindings(),
      initialRoute: Routes.initialRoute,
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
