import 'package:get/get.dart';
import 'package:quiz/src/global/shared.dart';

class TeacherHomeController extends GetxController {
  String get teacherName => sharedPreferences.getString('tName') ?? 'Unknown';
  String get teacherEmail => sharedPreferences.getString('temail') ?? 'Unknown';
  String get teacherPhone => sharedPreferences.getString('tPhone') ?? 'Unknown';
}
