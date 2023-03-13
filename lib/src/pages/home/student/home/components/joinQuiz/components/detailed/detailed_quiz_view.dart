import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz/src/model/quiz_detailed_join_model.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';

import '../controller/detailed_view_controller.dart';

class DetailedQuizViewScreen extends GetView<DetailedQuizController> {
  const DetailedQuizViewScreen({
    super.key,
    required this.model,
  });

  final DetailedQuizJoinModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizAppbar(
        appBarColor: kTeacherPrimaryColor,
        titleText: 'Quizzed',
        preferredSize: Size.fromHeight(56),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: kTeacherPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Title',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.title}',
                            overflow: TextOverflow.ellipsis,
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Description',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            '${model.description.toString().capitalize}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'QuizID',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            '${model.quizID}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Conducted By',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.conductedBy}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Subject Code',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.subjectCode}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Section',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.forSection}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'For Branch',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.forBranch}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'For Semester',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.forSemester}nd Semester',
                            overflow: TextOverflow.ellipsis,
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Total Question',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.totalQuestion}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Per Question Marks',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.perQsMarks}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Total Marks',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.totalMarks}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Quiz Duration',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.quizDuration} mins',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Current Student Joined Quiz',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.totalAppearedStudent} Student',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Text(
                        'Quiz Status',
                        style: kBodyText10Style(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: Text(
                            '${model.quizStatus.toString().capitalizeFirst}',
                            style: kBodyText9Style(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(

                //borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
            backgroundColor: kTeacherPrimaryColor,
          ),
          onPressed: () {},
          child: Text(
            'Join Quiz',
            style: kBodyText3Style(),
          ),
        ),
      ),
    );
  }
}
