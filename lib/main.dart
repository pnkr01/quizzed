import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quiz/src/app.dart';
import 'package:quiz/src/bindings/app_bindings.dart';
import 'package:quiz/src/global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  InitialBindings().dependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}
