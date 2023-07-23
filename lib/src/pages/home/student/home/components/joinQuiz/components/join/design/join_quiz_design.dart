import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quizzed/src/pages/home/student/home/components/joinQuiz/components/controller/join_quiz_session_controller.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';

import '../../../../../../../../../model/joined_quiz.dart';
import 'options.dart';

class JoinQuizDesign extends GetView<JoinQuizSessionController> {
  const JoinQuizDesign({
    Key? key,
    required this.questionString,
    required this.model,
    required this.questionLength,
    required this.options,
    required this.rindex,
  }) : super(key: key);

  final String questionString;
  final JoinedQuizModel model;
  final int questionLength;
  final int rindex;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.data?.questions![rindex].qsImage != null)
              Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: kTeacherPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: model.data?.questions![rindex].qsImage ??
                          'https://img.freepik.com/free-photo/portrait-young-woman-playing-with-vr-headset-glasses-virtual-reality-isolated-studio-vr-headset-glasses-device-technology-concept_58466-12923.jpg?size=626&ext=jpg&ga=GA1.2.1112508682.1676184457&semt=robertav1_2_sidr'),
                ),
              ),
            const SizedBox(
              height: 14,
            ),
            Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    questionLength,
                    (index) => Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.pageController.jumpToPage(index);
                          },
                          child: Material(
                            shape: const CircleBorder(side: BorderSide.none),
                            elevation: 4,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor:
                                  controller.currentIdx.value == index
                                      ? const Color.fromARGB(255, 224, 119, 189)
                                      : kQuizLightPrimaryColor,
                              child: Text('${index + 1}',
                                  style: kBodyText11Style()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '${questionString.toString().capitalizeFirst}',
              style: kBodyText11Style(),
              softWrap: true,
            ),
            //  const SizedBox(height: 10),
            ...List.generate(
              options.length,
              (index) => Option(
                cindex: rindex,
                model: model,
                index: index,
                text: options[index],
                press: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
