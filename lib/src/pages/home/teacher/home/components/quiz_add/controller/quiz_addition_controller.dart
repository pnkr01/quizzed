import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
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
  RxString uploadText = 'Upload Image (OPTIONAL)'.obs;
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
  RxBool isCreating = false.obs;

  bool isAllBlanksFilled() {
    return qsStatement.text.isNotEmpty &&
        option1.text.isNotEmpty &&
        option2.text.isNotEmpty &&
        option3.text.isNotEmpty &&
        option4.text.isNotEmpty;
  }

  Future createThisQuiz(PlatformFile? image) async {
    quizDebugPrint('created this quiz====================>');
    try {
      if (isAllBlanksFilled()) {
        return hitQuizApi(image);
      } else {
        showSnackBar('fill all blanks', redColor, whiteColor);
      }
    } catch (e) {
      showSnackBar(
        e.toString(),
        redColor,
        whiteColor,
      );
    }
  }

  uploadImageAndStuff() {}

  //PlatformFile? pickedFile;

  hitQuizApi(PlatformFile? image) async {
    var map = <String, dynamic>{};

    map['question_str'] = qsStatement.value.text.trim();
    map['options[0]'] = option1.value.text;
    map['options[1]'] = option2.value.text;
    map['options[2]'] = option3.value.text;
    map['options[3]'] = option4.value.text;
    map['correct_option'] = correctOptionValue.value.toString();
    map['subject'] = getSubjectCode();

    quizDebugPrint('map$map');

    Map<String, String> headers = {
      //'Content-Type': 'multipart/form-data',
      'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
    };
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
        request.fields["question_str"] = qsStatement.value.text.trim();
        request.fields["options[0]"] = option1.value.text.trim();
        request.fields["options[1]"] = option2.value.text.trim();
        request.fields["options[2]"] = option3.value.text.trim();
        request.fields["options[3]"] = option4.value.text.trim();
        request.fields["correct_option"] = correctOptionValue.value.toString();
        request.fields["subject"] = getSubjectCode();

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
        addQuestionToQuiz(responseData);
        //  if (response.statusCode == 200) {}
      } else {
        quizDebugPrint('no image');
        var response = await https.post(uri, headers: headers, body: map);
        var myjson = await jsonDecode(response.body);
        addQuestionToQuiz(myjson);
        quizDebugPrint(myjson.toString());
      }
    } catch (e) {
      quizDebugPrint(e.toString());
    }
  }

  addQuestionToQuiz(var myjson) async {
    try {
      await hitBucketRequest(myjson["question_id"]);
    } catch (e) {
      quizDebugPrint(e.toString());
    }
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
      quizDebugPrint('page value is ->>>>>>>>>>${page.value}');
      showSnackBar('Question Added sucessfully', greenColor, whiteColor);
      if (page.value == getTotalQs()) {
        //pause adding qs here and send data to backend
        //send user to home page.
        showSnackBar('Your quiz is ready go to all quiz for actions',
            greenColor, whiteColor);
        Get.offAllNamed(TeacherHome.routeName);
      } else {
        await clearThisController();
        correctOptionValue.value = 0;
        isCreating.value = false;
        pageController.nextPage(
            duration: const Duration(seconds: 1), curve: Curves.ease);
      }
    } else {
      showSnackBar(addedQuizJson["message"], redColor, whiteColor);
    }
  }

  hitBucketRequest(String qsID) async {
    quizDebugPrint(qsID);
    String putUrl =
        ApiConfig.getEndPointsNextUrl('quiz/add-question/${getQuizBucket()}');
    //log('post url-----------$putUrl');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
    };
    final bodyMsg = json.encode({
      "question_id": qsID,
    });
    quizDebugPrint(bodyMsg);
    var response = await https.put(
      headers: headers,
      body: bodyMsg,
      Uri.parse(putUrl),
    );
    var decode = jsonDecode(response.body);
    // log('decoding qsID--------------');
    //log(decode.toString());
    handleThisQuizAdditon(decode);
  }
}
