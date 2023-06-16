import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:share_plus/share_plus.dart';

import '../generate_report_model.dart';

class GenerateReportController extends GetxController {
  List<List<String>> itemList = [];
  TextEditingController quizID = TextEditingController();
  RxBool isLoading = false.obs;
  fetchResult() async {
    quizDebugPrint('e');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}',
      // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    final url =
        ApiConfig.getEndPointsNextUrl('quiz/generate-report/${quizID.text}');
    quizDebugPrint(url);
    final uri = Uri.parse(url);
    final response = await https.get(uri, headers: headers);
    quizDebugPrint(response.body);
    final decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      quizDebugPrint('REPORT GENERATED JSON IS $decoded');
      GenerateReport report = GenerateReport.fromJson(decoded);
      for (int i = 0; i < report.data!.length; i++) {
        //create a excel file
        //decode this values
        //save it
        //share it
        itemList.add(<String>[
          report.data![i].studentName!,
          report.data![i].studentRegdNo!,
          report.data![i].attemptedQuestionIds!.toString(),
          report.data![i].unattemptedQuestionIds!.toString(),
          report.data![i].correctQuestionIds!.toString(),
          report.data![i].incorrectQuestionIds!.toString(),
          report.data![i].marksObtained!.toString(),
        ]);
      }
      showSnackBar("Quiz report generated successfully.", kTeacherPrimaryColor,
          whiteColor);
      createExcel();
    } else {
      isLoading.value = !isLoading.value;
      showSnackBar(decoded["message"], kTeacherPrimaryColor, whiteColor);
    }
  }

  createExcel() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      generateCsv();
    } else {
      await Permission.storage.request();
    }
  }

  late Directory directory;
  String path = '';

  void generateCsv() async {
    String csvData = const ListToCsvConverter().convert(itemList);
    if (Platform.isAndroid) {
      directory = (await getExternalStorageDirectory())!;

      path = '${directory.path}/${quizID.text}.csv';
      final File file = File(path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        itemList = [
          <String>[
            'Name',
            'RegdNo',
            'Attempted',
            'Unattempted',
            'Correct',
            'Incorrect',
            'MarksObatined'
          ]
        ];
        await file.writeAsString(csvData);
        // dio.download(urlPath, savePath);
        //itemList = [];

        isLoading.value = !isLoading.value;
        Share.shareFiles([path], text: quizID.text);
      }
    }
  }
}
