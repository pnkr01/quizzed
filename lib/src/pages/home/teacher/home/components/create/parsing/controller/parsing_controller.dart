import 'dart:async';
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
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/controller/draft_quiz_controller.dart';
import 'package:quiz/src/pages/home/teacher/teacher_home.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

class ParsingController extends GetxController {
  RxBool isLoading = false.obs;
  dynamic argumentData = Get.arguments;
  Map<String, String> headers = {
    'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
  };
  getSubCode() => argumentData[0]['code'] ?? "";
  getQuizID() => argumentData[1]['quizID'];
  getTotalQs() => argumentData[2]['totlaQs'];

  late RxInt tot = 0.obs;

  @override
  void onInit() {
    quizDebugPrint(getSubCode());
    quizDebugPrint(getTotalQs());
    tot.value = getTotalQs();
    quizDebugPrint('tot value is ${tot.value}');
    super.onInit();
  }

  RxInt totalQsAdded = 0.obs;

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
    } else {
      isLoading.value = false;
      showSnackBar('file cancelled by Teacher', redColor, whiteColor);
    }
  }

  final completer = Completer<void>();

  Future parseExcelFile(File file) async {
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    final sheet = excel.tables['Sheet1'];
    // final questions = <Question>[];

    //handle checks
    final row = sheet!.rows[0];

    totalQsLength = sheet.rows.length - 1;
    quizDebugPrint(
        'totalQsLength is $totalQsLength and total length you enter is ${getTotalQs()}');
    isLoading.value = false;
    quizDebugPrint(totalQsLength);
    if (totalQsLength >= tot.value - 1) {
      for (i = 0; i <= totalQsLength; i++) {
        text.value = '${i + 1} of ${totalQsLength + 1}';
        final row = sheet.rows[i];
        await waitForUserInteraction(row);
      }
      quizDebugPrint('i value is $i and totalQsAdded is ${totalQsAdded.value}');
      if (totalQsAdded.value - 1 == i) {
        Get.offAllNamed(TeacherHome.routeName);
        showSnackBar('Your quiz is ready go to all quiz for actions',
            greenColor, whiteColor);
      } else {
        showSnackBar("pick other file to add remainig question",
            kTeacherPrimaryColor, whiteColor);
      }
    } else {
      showSnackBar('Quiz is less in excel..', greenColor, whiteColor);
    }
  }

  hitBucketRequest(String questionID) async {
    quizDebugPrint(questionID);
    quizDebugPrint(getQuizID());
    quizDebugPrint('htiing bucket 133');
    String putUrl =
        ApiConfig.getEndPointsNextUrl('quiz/add-question/${getQuizID()}');
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
    handleThisQuizAdditon(decode);
  }

  handleThisQuizAdditon(var addedQuizJson) async {
    quizDebugPrint('updateing---------------->');
    totalQsAdded.value = totalQsAdded.value + 1;
    if (addedQuizJson["message"]
        .toString()
        .contains('Question added to quiz')) {
      //increase loader
      showSnackBar('Question Added sucessfully', greenColor, whiteColor);
      if (pickedFile != null) {
        Get.back();
        pickedFile = null;
        if (image != null) {
          image = null;
        }
      }
    } else {
      Get.offAllNamed(TeacherHome.routeName);
      showSnackBar(addedQuizJson["message"], redColor, whiteColor);
    }
  }

  PlatformFile? pickedFile;
  RxBool isShowImage = false.obs;
  File? image;
  var result;
  RxString uploadText = 'Upload'.obs;

  handleFileUpload() async {
    result = await FilePicker.platform.pickFiles();
    if (result != null) {
      uploadText.value = 'Selected';
      pickedFile = result.files.first;
      quizDebugPrint("${pickedFile!.path}--path");
    } else {
      showSnackBar('No Image selected', blackColor, whiteColor);
    }
  }

  Future<void> waitForUserInteraction(row) async {
    final completer = Completer<void>();

    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async =>
              false, // Prevent dialog dismissal on back button press
          child: AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      // color: kTeacherPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Text(
                    'Qs : ${row[0]!.value}',
                    style: const TextStyle(color: blackColor),
                  ),
                ),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: const Color(0xffc4c4c4),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: row[5].value == 0 ? greenColor : null,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      'Op1 : ${row[1]!.value}',
                      style: TextStyle(
                          color: row[5].value == 0 ? whiteColor : blackColor),
                    )),
                Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: row[5].value == 1 ? greenColor : null,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      'Op2 : ${row[2]!.value}',
                      style: TextStyle(
                          color: row[5].value == 1 ? whiteColor : blackColor),
                    )),
                Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: row[5].value == 2 ? greenColor : null,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      'Op3 : ${row[3]!.value}',
                      style: TextStyle(
                          color: row[5].value == 2 ? whiteColor : blackColor),
                    )),
                Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: row[5].value == 3 ? greenColor : null,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      'Op4 : ${row[4]!.value}',
                      style: TextStyle(
                          color: row[5].value == 3 ? whiteColor : blackColor),
                    )),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kTeacherPrimaryColor),
                    onPressed: () {
                      handleFileUpload();
                    },
                    child: Obx(() => Text(uploadText.value)),
                  ),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: kTeacherPrimaryColor,
                    ),
                    child: Obx(() => Center(
                          child: Text(
                            '${totalQsAdded.value}',
                            style: const TextStyle(color: whiteColor),
                          ),
                        ))),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE1E4FF),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: Color(0xFF6779FE),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kTeacherPrimaryColor),
                child: const Text('Skip'),
                onPressed: () async {
                  showSnackBar("Skipped ", kTeacherPrimaryColor, whiteColor);
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  uploadText.value = 'Upload';
                  completer.complete();
                },
              ),
              const SizedBox(width: 4),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kTeacherPrimaryColor),
                child: const Text('Add'),
                onPressed: () async {
                  await hitQuizApi(
                    row[0]!.value.toString(),
                    row[1]!.value.toString(),
                    row[2]!.value.toString(),
                    row[3]!.value.toString(),
                    row[4]!.value.toString(),
                    row[5]!.value.toString(),
                    getSubCode(),
                    pickedFile,
                    getQuizID(),
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                  uploadText.value = 'Upload';
                  completer.complete();
                },
              ),
            ],
          ),
        );
      },
    );

    return completer.future;
  }

  Future hitQuizApi(String qs, String op1, String op2, String op3, String op4,
      String co, subjCode, PlatformFile? image, String quizID) async {
    var map = <String, dynamic>{};
    quizDebugPrint('correct op is $co');

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
        showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) => WillPopScope(
                onWillPop: () async => true,
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      LinearProgressIndicator(
                        color: kTeacherPrimaryColor,
                      ),
                      Text('uploading..')
                    ],
                  ),
                )));
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
        try {
          var response = await https.post(uri, headers: headers, body: map);
          var myjson = await jsonDecode(response.body);
          quizDebugPrint('my json is ${myjson.toString()}');
          quizDebugPrint('questionId is ${myjson["question_id"]}');
          hitBucketRequest(myjson["question_id"]);
        } catch (e) {
          showSnackBar("$e contact developer code 351", greenColor, whiteColor);
        }
      }
    } catch (e) {
      Get.offAllNamed(TeacherHome.routeName);
      Get.find<DraftQuizController>().handleDeleteButton(getQuizID());
      showSnackBar(e.toString(), greenColor, whiteColor);
    }
  }
}
