import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/routes/app_routes.dart';

import 'bindings/app_bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorkey,
      title: 'Quiz App',
      getPages: AppRoute.pages(),
      initialRoute: '/',
    );
  }
}
