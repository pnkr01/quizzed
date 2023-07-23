import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/global/shared.dart';
import 'package:quizzed/src/pages/home/student/home/components/joinQuiz/components/controller/option_controller.dart';
import 'package:quizzed/utils/custom_circular.dart';

import '../../../../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../../../model/joined_quiz.dart';

class Option extends StatefulWidget {
  const Option({
    Key? key,
    required this.text,
    required this.model,
    required this.index,
    required this.cindex,
    required this.press,
  }) : super(key: key);
  final String text;
  final JoinedQuizModel model;
  final int index;
  final int cindex;
  final VoidCallback press;

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<OptionController>();
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onTap: widget.press,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: const BoxDecoration(
            //borderRadius: BorderRadius.circular(15),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
                child: Text("${widget.index + 1}. ${widget.text}",
                    style: kBodyText11Style())),
            Radio(
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                return whiteColor;
              }),
              toggleable: true,
              activeColor: whiteColor,
              value: widget.index,
              // ignore: prefer_if_null_operators
              groupValue: controller.getValue(
                  widget.model.data!.questions![widget.cindex].questionId),
              onChanged: (val) {
                CustomCircleLoading.showDialog();
                quizDebugPrint(widget.index);
                controller.correctOptionValue.value = val as int;
                prefs.setInt(
                    widget.model.data!.questions![widget.cindex].questionId!,
                    controller.correctOptionValue.value);
                //hit answerApi and change to next page.

                // controller.saveLocalAnswer(val);

                controller.maintainAnswerApi(widget.model, val);
              },
            ),
          ],
        ),
      ),
    );
  }
}
