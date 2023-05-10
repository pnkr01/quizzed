import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:quiz/src/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/global/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  prefs = await SharedPreferences.getInstance();
  //await dotenv.load(fileName: "assets/env/.env");
  //InitialBindings().dependencies();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}
