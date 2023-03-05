import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
//-------------------------------Teacher Cookie---------------------//
setTeacherCookie(response) async {
  String rawCookie = response.headers['set-cookie']!;
  int index = rawCookie.indexOf(';');
  String refreshToken =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
  int idx = refreshToken.indexOf("=");
  if (kDebugMode) {
    print(refreshToken.substring(idx + 1).trim());
  }
  String cookieID = refreshToken.substring(idx + 1).trim();
  sharedPreferences.setString('Tcookie', cookieID);
  log("Cookieeeeee  $cookieID");
  //-------------------------------Teacher Cookie---------------------//
}
