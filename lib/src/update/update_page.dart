import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzed/src/update/controller/update_app_controller.dart';

import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/utils/quizAppBar.dart';
import 'package:quizzed/utils/quizElevatedButon.dart';

class UpdateScreenPage extends GetView<UpdateAppController> {
  final String apkUrl;
  const UpdateScreenPage({
    Key? key,
    required this.apkUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizAppbar(
        titleText: "Update",
        preferredSize: Size.fromHeight(60),
        appBarColor: kTeacherPrimaryColor,
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Container(
              padding: const EdgeInsets.all(20),
              child: QuizElevatedButton(
                  label: const Text("Start Update"),
                  backgroundColor: kTeacherPrimaryColor,
                  function: () {
                    controller.downloadAndInstallUpdate(apkUrl, context);
                  })),
        ),
      ),
    );
  }
}
