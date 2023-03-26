import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz/src/pages/home/student/home/components/joinQuiz/components/controller/join_quiz_session_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

import '../../../../../../../../../model/joined_quiz.dart';
import 'options.dart';

class JoinQuizDesign extends GetView<JoinQuizSessionController> {
  const JoinQuizDesign({
    Key? key,
    required this.questionString,
    required this.model,
    required this.questionLength,
    required this.options,
    required this.index,
  }) : super(key: key);

  final String questionString;
  final JoinedQuizModel model;
  final int questionLength;
  final int index;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                imageUrl: model.data?.questions![index].qsImage ??
                    'https://img.freepik.com/free-vector/exams-concept-illustration_114360-2754.jpg?w=740&t=st=1678810269~exp=1678810869~hmac=6c3db4b7a66ed4eccbb08b9928325dc739dbe64f41ed6176d749d6d406efad63',
              ),
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
                            child:
                                Text('${index + 1}', style: kBodyText11Style()),
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
          Text('${questionString.toString().capitalizeFirst}',
              style: kBodyText11Style()),
          //  const SizedBox(height: 10),
          ...List.generate(
            options.length,
            (index) => Option(
              model: model,
              index: index,
              text: options[index],
              press: () {},
            ),
          ),
        ],
      ),
    );
  }
}
