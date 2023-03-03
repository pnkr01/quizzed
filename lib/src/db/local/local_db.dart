import 'package:quiz/src/global/shared.dart';

class LocalDB {
  static Future<void> saveStudentModel(Map<String, dynamic> data) async {
    sharedPreferences.setString('regdNo', data["regdNo"]);
    sharedPreferences.setString('name', data["name"]);
    sharedPreferences.setString('phone', data["primaryPhone"] ?? "Unknown");
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
