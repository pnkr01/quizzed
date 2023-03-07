import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/src/global/shared.dart';

class AddQuizController extends GetxController {
  dynamic arguments = Get.arguments;

  RxInt page = 0.obs;
  RxInt correctOptionValue = 0.obs;
  int get currentQs => page.value;
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
      // try {
      //   log('id----${myjson["_id"]}\n');
      //   await hitBucketRequest(myjson["_id"]);
      // } catch (e) {
      //   log(e.toString());
      // }
    } catch (e) {
      log(e.toString());
    }
    log('after api------------------');
  }

  hitBucketRequest(qsIs) async {
    String postUrl =
        ApiConfig.getEndPointsNextUrl('quiz/add-question/${getQuizBucket()}');
    log('post url-----------$postUrl');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
    };
    final bodyMsg = {
      "question_db_id": qsIs,
    };
    var response = await https.put(
      headers: headers,
      body: bodyMsg,
      Uri.parse(ApiConfig.getEndPointsNextUrl(postUrl)),
    );
    var decode = jsonDecode(response.body);
    log('decoding qsID--------------');
    log(decode.toString());
  }
}
