import 'dart:developer';

import 'package:quiz/src/global/shared.dart';

class LocalDB {
  static saveStudentModel(String name, String regdNo) {
    sharedPreferences.setString('name', name);
    sharedPreferences.setString('regdNo', regdNo);
  }

  static Future<void> saveTeacherData(Map<String, dynamic> data) async {
    sharedPreferences.setString('tId', data['_id']);
    sharedPreferences.setString('tregdNo', data['regdNo']);
    sharedPreferences.setString('temail', data['email']);
    sharedPreferences.setString('tName', data['name']);
    sharedPreferences.setString('tPhone', data['primaryPhone']);
    //return data;
  }
}
