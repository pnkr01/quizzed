import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/model/student_model.dart';

class LocalDB {
  saveStudentModel(Student student) {
    sharedPreferences.setString('name', student.name!);
    sharedPreferences.setString('regdNo', student.regdNo!);
  }

  static saveTeacherData(Map<String, dynamic> data) {
    sharedPreferences.setString('tId', data['_id']);
    sharedPreferences.setString('tregdNo', data['regdNo']);
    sharedPreferences.setString('temail', data['email']);
    sharedPreferences.setString('tName', data['name']);
    sharedPreferences.setString('tPhone', data['primaryPhone']);
    //return data;
  }
}
