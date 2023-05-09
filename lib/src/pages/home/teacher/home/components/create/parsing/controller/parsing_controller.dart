import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/show_all_quiz.dart';
import 'package:quiz/src/pages/home/teacher/home/components/quiz_add/controller/quiz_view_screen_controller.dart';
import 'package:quiz/src/pages/home/teacher/teacher_home.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

class ParsingController extends GetxController {
  dynamic argumentData = Get.arguments;
  Map<String, String> headers = {
    'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
  };
  getSubCode() => argumentData[0]['code'] ?? "";
  getQuizID() => argumentData[1]['quizID'];

  RxString text = "Parsing..".obs;

  num totalQsLength = 0;
  int i = 0;

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      PlatformFile platformFile = result.files.first;
      File file = File(platformFile.path!);
      parseExcelFile(file);
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const LinearProgressIndicator(
                  color: kTeacherPrimaryColor,
                  backgroundColor: Colors.transparent),
              const SizedBox(height: 15.0),
              Obx(() => Text(text.value))
            ],
          ),
        ),
      );
      //start parsing
    } else {
      showSnackBar('file cancelled by Teacher', redColor, whiteColor);
    }
  }

  Future parseExcelFile(File file) async {
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables['Sheet1'];
    // final questions = <Question>[];

    //handle checks
    final row = sheet!.rows[0];

    totalQsLength = sheet.rows.length - 1;
    quizDebugPrint('totalQsLength is $totalQsLength');
    for (i = 0; i <= totalQsLength; i++) {
      text.value = '${i + 1} of ${totalQsLength + 1}';
      final row = sheet.rows[i];
      quizDebugPrint('hitting quiz api');
      try {
        await hitQuizApi(
          row[0]!.value.toString(),
          row[1]!.value.toString(),
          row[2]!.value.toString(),
          row[3]!.value.toString(),
          row[4]!.value.toString(),
          row[5]!.value.toString(),
          getSubCode(),
          null,
          getQuizID(),
        );
      } catch (e) {
        Get.back();
        showSnackBar('Error occured ', redColor, whiteColor);
      }
    }
    Get.offAllNamed(TeacherHome.routeName);
    showSnackBar('Your quiz is ready go to all quiz for actions', greenColor,
        whiteColor);
  }

  Future hitQuizApi(String qs, String op1, String op2, String op3, String op4,
      String co, subjCode, PlatformFile? image, String quizID) async {
    var map = <String, dynamic>{};

    map['question_str'] = qs;
    map['options[0]'] = op1;
    map['options[1]'] = op2;
    map['options[2]'] = op3;
    map['options[3]'] = op4;
    map['correct_option'] = co;
    map['subject'] = subjCode;

    quizDebugPrint('map----------> $map');

    // Map<String, String> headers = {
    //   //'Content-Type': 'multipart/form-data',
    //   'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
    // };
    try {
      https.MultipartRequest request;
      final uri = Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/questions'));
      if (image != null) {
        quizDebugPrint('image ${image.toString()}');
        // var stream = https.ByteStream(image.openRead());
        // stream.cast();
        // var length = await image.length();
        //quizDebugPrint('length of image is $length');
        request = https.MultipartRequest('POST', uri);
        request.fields["question_str"] = qs;
        request.fields["options[0]"] = op1;
        request.fields["options[1]"] = op2;
        request.fields["options[2]"] = op3;
        request.fields["options[3]"] = op4;
        request.fields["correct_option"] = co;
        request.fields["subject"] = subjCode;

        final File imageFile = File(image.path!);
        final List<int> imageBytes = await imageFile.readAsBytes();

        request.files.add(https.MultipartFile.fromBytes(
          'file',
          imageBytes,
          filename: image.name,
        ));
        request.headers.addAll(headers);
        var response = await request.send();
        var responsed = await https.Response.fromStream(response);
        final responseData = json.decode(responsed.body);
        quizDebugPrint("${responseData.toString()}---------->");
        hitBucketRequest(responseData["question_id"]);
        //  if (response.statusCode == 200) {}
      } else {
        quizDebugPrint('no image');
        var response = await https.post(uri, headers: headers, body: map);
        var myjson = await jsonDecode(response.body);
        quizDebugPrint(myjson.toString());
        hitBucketRequest(myjson["question_id"]);
      }
    } catch (e) {
      Get.offAllNamed(TeacherHome.routeName);
      Get.find<QuizAdditionController>().handleEraseButton(getQuizID());
      showSnackBar(e.toString(), greenColor, whiteColor);
    }
  }

  hitBucketRequest(String questionID) async {
    quizDebugPrint(questionID);
    quizDebugPrint(getQuizID());
    quizDebugPrint('htiing bucket 133');
    String putUrl =
        ApiConfig.getEndPointsNextUrl('quiz/add-question/${getQuizID()}');
    //log('post url-----------$putUrl');

    quizDebugPrint(putUrl);

    final bodyMsg = {"question_id": questionID};
    quizDebugPrint(bodyMsg.runtimeType);
    quizDebugPrint(bodyMsg);
    var response = await https.put(
      headers: headers,
      body: bodyMsg,
      Uri.parse(putUrl),
    );
    var decode = jsonDecode(response.body);
    // log('decoding qsID--------------');

    quizDebugPrint('handling quiz addition');
    quizDebugPrint(decode.toString());
    //handleThisQuizAdditon(decode);
  }

  handleThisQuizAdditon(var addedQuizJson) async {
    if (addedQuizJson["message"]
        .toString()
        .contains('Question added to quiz')) {
      //increase loader
      showSnackBar('Question Added sucessfully', greenColor, whiteColor);

      if (i == totalQsLength) {
        Get.offAllNamed(ShowAllCreatedQuiz.routeName);
        showSnackBar('Your quiz is ready go to all quiz for actions',
            greenColor, whiteColor);
        // all question added
        // send to all quiz screen and show confirm dialog
      } else {
        //inc loader value.
        Future.delayed(const Duration(seconds: 2));
      }
    } else {
      // Get.offAllNamed(TeacherHome.routeName);
      showSnackBar(addedQuizJson["message"], redColor, whiteColor);
    }
  }
}
