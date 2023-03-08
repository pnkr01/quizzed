import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/pages/home/teacher/teacher_home.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/src/global/shared.dart';

class AddQuizController extends GetxController {
  dynamic arguments = Get.arguments;

  RxInt page = 0.obs;
  RxInt correctOptionValue = 0.obs;
  final Rx<Color> onTapColor1 = kTeacherPrimaryshadeColor.obs;
  final PageController pageController = PageController(initialPage: 0);

  TextEditingController qsStatement = TextEditingController();
  TextEditingController option1 = TextEditingController();
  TextEditingController option2 = TextEditingController();
  TextEditingController option3 = TextEditingController();
  TextEditingController option4 = TextEditingController();
  getQuizBucket() => arguments[0]["quizBucketID"];
  getSubject() => arguments[1]["subject"];
  getTotalQs() => arguments[2]["totalQs"];
  getSubjectCode() => arguments[3]["subjectCode"];

  final List<Widget> pageList = [];

  createThisQuiz() {
    log('created this quiz====================>');
    //1. check for empty
    log('hit api------------->');
    log('');
    try {
      hitQuizApi();
    } catch (e) {
      showSnackBar(
        e.toString(),
        redColor,
        whiteColor,
      );
    }
  }

  hitQuizApi() async {
    var map = <String, dynamic>{};

    map['question_str'] = qsStatement.value.text.trim();
    map['options[0]'] = option1.value.text;
    map['options[1]'] = option2.value.text;
    map['options[2]'] = option3.value.text;
    map['options[3]'] = option4.value.text;
    map['correct_option'] = correctOptionValue.value.toString();
    map['subject'] = getSubjectCode();

    log('map$map');

    Map<String, String> headers = {
      //'Content-Type': 'multipart/form-data',
      'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
    };
    // final msg = json.encode({});
    log('sending to create quiz in /create route');
    log('start hitting create api ==============================>');
    try {
      var response = await https.post(
          Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/questions')),
          headers: headers,
          body: map);
      var myjson = await jsonDecode(response.body);
      log(myjson.toString());
      log('adding this qs id into bucket------------------');
      try {
        log('id----${myjson["_id"]}\n');
        await hitBucketRequest(myjson["_id"]);
      } catch (e) {
        log(e.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    log('after api------------------');
  }

  clearThisController() {
    qsStatement.clear();
    option1.clear();
    option2.clear();
    option3.clear();
    option4.clear();
  }

  handleThisQuizAdditon(var addedQuizJson) async {
    if (addedQuizJson["message"]
        .toString()
        .contains('Question added to quiz')) {
      page.value += 1;
      log('page value is ->>>>>>>>>>${page.value}');
      showSnackBar('Quiz Added sucessfully', greenColor, whiteColor);
      if (page.value == getTotalQs()) {
        //pause adding qs here and send data to backend
        //send user to home page.
        Get.offAllNamed(TeacherHome.routeName);
        showSnackBar('All Quiz Added Sucessfully', greenColor, whiteColor);
      } else {
        await clearThisController();
        correctOptionValue.value = 0;
        pageController.nextPage(
            duration: const Duration(seconds: 1), curve: Curves.ease);
      }
    } else {
      showSnackBar(addedQuizJson["message"], redColor, whiteColor);
    }
  }

  hitBucketRequest(String qsIs) async {
    String putUrl =
        ApiConfig.getEndPointsNextUrl('quiz/add-question/${getQuizBucket()}');
    log('post url-----------$putUrl');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
    };
    final bodyMsg = json.encode({
      "question_db_id": qsIs,
    });
    var response = await https.put(
      headers: headers,
      body: bodyMsg,
      Uri.parse(putUrl),
    );
    var decode = jsonDecode(response.body);
    log('decoding qsID--------------');
    log(decode.toString());
    handleThisQuizAdditon(decode);
  }
}
