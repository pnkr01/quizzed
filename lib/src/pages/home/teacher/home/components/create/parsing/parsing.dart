import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/teacher/home/components/create/parsing/controller/parsing_controller.dart';
import 'package:quiz/theme/app_color.dart';

class Parsing extends GetView<ParsingController> {
  const Parsing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeacherPrimaryColor,
        title: const Text('Parsing'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: kTeacherPrimaryColor),
                child: const Text('Pick File'),
                onPressed: () {
                  controller.pickFile();
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: const Text(
                'We need storage permission to pick excel file, Tap on pick file and give permission you haven\'t given. '),
          )
        ],
      ),
    );
  }
}
