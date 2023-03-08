import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quiz/src/pages/home/teacher/home/components/quiz_add/quiz_confirm_view_screen.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../../utils/errordialog.dart';

class CreateQuizController extends GetxController {
  late final Rx<TextEditingController> title = TextEditingController().obs;
  late final Rx<TextEditingController> description =
      TextEditingController().obs;
  late final Rx<TextEditingController> section = TextEditingController().obs;
  late final Rx<TextEditingController> semester = TextEditingController().obs;
  late final Rx<TextEditingController> totalQs = TextEditingController().obs;
  late final Rx<TextEditingController> marksPerQs = TextEditingController().obs;
  late final Rx<TextEditingController> duration = TextEditingController().obs;
  late final Rx<TextEditingController> search = TextEditingController().obs;

  final FocusNode focusNodeTitle = FocusNode();
  final FocusNode focusNodesection = FocusNode();
  final FocusNode focusNodeDescription = FocusNode();
  final FocusNode focusNodesemester = FocusNode();
  final FocusNode focusNodeDtotalQs = FocusNode();
  final FocusNode focusNodemarksPerQs = FocusNode();
  final FocusNode focusNodeduration = FocusNode();

  RxBool isFetching = true.obs;

  Map<String, String> subject = {
    "Computer Science": "CSE1452",
    "Compyer App": "EE554",
    "Compyer eee": "TT554",
    "TEREE App": "EOU554",
    "LOLP App": "E22554",
    "RETE App": "E85554",
  };
  List showSubjectList = [];
  @override
  void onInit() {
    fillMySubject();
    super.onInit();
  }

  fillMySubject() {
    subject.forEach((key, value) {
      showSubjectList.add(key);
    });
    isFetching.value = false;
  }

  navigateToQuizAdditionPage() {}

  String getEquivalentCode(String key) {
    print(subject[key]);
    return subject[key]!;
  }

  checkThisCreateQuizTap() {
    if (title.value.text.isNotEmpty &&
        description.value.text.isNotEmpty &&
        section.value.text.isNotEmpty &&
        semester.value.text.isNotEmpty &&
        totalQs.value.text.isNotEmpty &&
        marksPerQs.value.text.isNotEmpty &&
        duration.value.text.isNotEmpty &&
        search.value.text.isNotEmpty) {
      log('create quiz is in process =>>>>>>>>>>>>>>');

      try {
        if (section.value.text.contains('-')) {
          startProcessingCreateQuiz(
            title.value.text.trimRight(),
            description.value.text.trimRight(),
            getEquivalentCode(search.value.text.trimRight()),
            section.value.text.toUpperCase().trimRight(),
            semester.value.text.trimRight(),
            totalQs.value.text.trimRight(),
            marksPerQs.value.text.trimRight(),
            duration.value.text.trimRight(),
          );
        } else {
          Get.back();
          showSnackBar(
            'Enter correct section format. e.g CSE-K',
            redColor,
            whiteColor,
          );
        }
      } catch (e) {
        Get.back();
        log('ERROR');
        showSnackBar(e.toString(), redColor, whiteColor);
      }
    } else {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: ((context) =>
              const ErrorDialog(message: 'fill all blanks')));
    }
  }

  //-------------------------------------------------//

  startProcessingCreateQuiz(
      String title,
      String desc,
      String sub,
      String section,
      String semester,
      String tQS,
      String eachQsmarks,
      String duration) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw==',
      'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
    };
    final msg = json.encode({
      "title": title,
      "description": desc,
      "subject": sub,
      "section": section,
      "semester": int.parse(semester),
      "total_questions": int.parse(tQS),
      "per_question_marks": int.parse(eachQsmarks),
      "duration": int.parse(duration)
    });
    log('start hitting create api ==============================>');
    var response = await https.post(
      Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/create')),
      headers: headers,
      body: msg,
    );
    var myjson = await jsonDecode(response.body);
    print(myjson);
    if (myjson["message"] == "Unauthorized") {
      log('Teacher JWT Expired ====> Sending to login screen to login again');
      log('clearning local DB========================>');
      sharedPreferences.clear();
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      showSnackBar('Your session expired :)', greenColor, whiteColor);
    } else if (myjson["quiz_id"] != null) {
      Get.back();
      log(myjson.toString());
      log('sending to add question page---------------------------------------->');
      Get.offNamed(
        QuizAdditionScreen.routeName,
        arguments: [
          {"subject": search.value.text.trimRight()},
          {"quiz_id": myjson["quiz_id"]},
          {"conducted_by": myjson["conducted_by"]},
          {"title": myjson["title"]},
          {"section": myjson["section"]},
          {"semester": myjson["semester"]},
          {"duration": myjson["duration"]},
          {"created_at": myjson["created_at"]},
          {"updated_at": myjson["updated_at"]},
          {"status": myjson["status"]},
          {"description": myjson["description"]},
          {"total_questions": myjson["total_questions"]},
          {"per_question_marks": myjson["per_question_marks"]},
          {"subjectCode": myjson["subject"]},
        ],
      );
    } else {
      Get.back();
      showSnackBar(myjson["message"], redColor, whiteColor);
    }
  }

  //send to krishna subject[key]
}
