import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import '../../../../../../../../theme/app_color.dart';
import '../../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../api/points.dart';
import '../../../../../../../global/global.dart';
import '../../../../../../../global/shared.dart';
import '../../../../teacher_home.dart';
import '../quiz_additon_view_screen.dart';

class QuizAdditionController extends GetxController {
  dynamic argumentData = Get.arguments;

  //----------------------------Get arguments start------------------------------//
  getSubject() => argumentData[0]['subject'];
  getQuizId() => argumentData[1]['quiz_id'];
  getAuthor() => argumentData[2]['conducted_by'];
  getTitle() => argumentData[3]['title'];
  getSection() => argumentData[4]['section'];
  getSemester() => argumentData[5]['semester'];
  getDuration() => argumentData[6]['duration'];
  getCreatedAt() => argumentData[7]['created_at'];
  getLastUpdate() => argumentData[8]['updated_at'];
  getStatus() => argumentData[9]['status'];
  getDescription() => argumentData[10]['description'];
  getTotalQs() => argumentData[11]['total_questions'];
  getMarksPerQs() => argumentData[12]['per_question_marks'];
  getSubjectCode() => argumentData[13]['subjectCode'];
  //------------------------------Close---------------------------//

  navigateToQuizCreatePage() {
    Get.toNamed(QuizAdditionView.routeName, arguments: [
      {"quizBucketID": getQuizId()},
      {"subject": getSubject()},
      {"totalQs": getTotalQs()},
      {"subjectCode": getSubjectCode()},
    ]);
  }

  // handleEraseButton() async {
  //   try {
  //     //log('er');
  //     Map<String, String> headers = {
  //       'Content-Type': 'application/json',
  //       'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}',
  //       // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  //     };
  //     var response = await https.delete(
  //       Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/${getQuizId()}')),
  //       headers: headers,
  //     );
  //     print(response.body);
  //     var decode = jsonDecode(response.body);
  //     if (decode["statusCode"] == 200) {
  //       Get.offAllNamed(TeacherHome.routeName);
  //       Future.delayed(const Duration(seconds: 1), () {
  //         showSnackBar('Deleted Sucesfully :)', greenColor, whiteColor);
  //       });
  //     } else {
  //       Get.offAllNamed(TeacherHome.routeName);
  //       Future.delayed(const Duration(seconds: 1), () {
  //         showSnackBar('Network Error :)', redColor, whiteColor);
  //       });
  //     }
  //   } catch (e) {
  //     Get.offAllNamed(TeacherHome.routeName);
  //     Future.delayed(const Duration(seconds: 1), () {
  //       showSnackBar('Network Error :)', redColor, whiteColor);
  //     });
  //   }
  // }
}
