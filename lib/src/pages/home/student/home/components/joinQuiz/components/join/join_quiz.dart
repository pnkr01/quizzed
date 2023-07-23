import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:get/get.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/global/shared.dart';
import 'package:quizzed/src/model/joined_quiz.dart';
import 'package:quizzed/src/pages/home/student/home/components/joinQuiz/components/controller/join_quiz_session_controller.dart';
import 'package:quizzed/src/pages/home/student/home/components/joinQuiz/components/controller/option_controller.dart';
import 'package:quizzed/src/pages/home/student/home/student_home.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import 'package:quizzed/utils/quizAppBar.dart';
import 'package:quizzed/utils/time_helper.dart';
import '../../../../../../../../../utils/quizElevatedButon.dart';
import 'design/join_quiz_design.dart';

class JoinQuizSessionScreen extends StatefulWidget {
  static String routeName = '/joinQuiz';
  const JoinQuizSessionScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  final JoinedQuizModel model;

  @override
  State<JoinQuizSessionScreen> createState() => _JoinQuizSessionScreenState();
}

class _JoinQuizSessionScreenState extends State<JoinQuizSessionScreen>
    with WidgetsBindingObserver {
  var controller = Get.find<JoinQuizSessionController>();
  var optionController = Get.find<OptionController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool _isInForeground = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    quizDebugPrint(state.toString());
    switch (state) {
      case AppLifecycleState.resumed:
        setState(() {
          _isInForeground = true;
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        setState(() {
          _isInForeground = false;
        });
        // Wait for 15 seconds and then do something
        Future.delayed(const Duration(seconds: 15), () async {
          if (!_isInForeground) {
            // Do something

            //func for force submit the user user.
            //send to home page.
            quizDebugPrint('you have spent 15 sec');
            if (mounted) {
              controller.stoptheTimer();
            }
            await FlutterDnd.setInterruptionFilter(
                FlutterDnd.INTERRUPTION_FILTER_NONE);
            Get.offAllNamed(StudentHome.routeName);
            //locally handling force stopping
            sharedPreferences.setBool(controller.getQuizID(), true);
            quizDebugPrint(controller.getQuizID());
            quizDebugPrint(sharedPreferences.getBool(controller.getQuizID()));
            // ignore: use_build_context_synchronously
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'You are not in the quiz app for more than 15 sec, your quiz is forced submitted sucessfully, Please check your result after the quiz ends.',
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kTeacherPrimaryColor),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Okay'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.model.data?.questions?.shuffle();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: QuizAppbar(
          leading: const SizedBox(),
          appBarColor: kQuizPrimaryColor,
          titleText: 'Quizzed',
          preferredSize: const Size.fromHeight(56),
          tariling: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.timer, color: kTeacherPrimaryColor),
                  const SizedBox(width: 4),
                  // Text(
                  //   controller.getTime.value,
                  //   style: kDesignSmallTextStyle(),
                  // ),
                  TimerWidgetHelper(
                      quizID: widget.model.data!.quizStats!.quizId!),
                ],
              )),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Card(
                color: kQuizLightPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'QuizID : ',
                            style: kBodyText11Style(),
                          ),
                          Text(
                            '${widget.model.data?.quizStats?.quizId}',
                            style: kBodyText11Style(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            'Regd No : ',
                            style: kBodyText11Style(),
                          ),
                          Text(
                            '${widget.model.data?.quizStats?.studentRegdNo}',
                            style: kBodyText11Style(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 2,
                child: Card(
                  elevation: 50,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  color: kQuizLightPrimaryColor,
                  child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: widget.model.data?.questions?.length,
                      onPageChanged: ((value) =>
                          controller.onPageChanged(value)),
                      itemBuilder: ((context, index) {
                        return JoinQuizDesign(
                          rindex: index,
                          model: widget.model,
                          questionLength: widget.model.data!.questions!.length,
                          options:
                              widget.model.data!.questions![index].options!,
                          questionString:
                              widget.model.data!.questions![index].questionStr!,
                        );
                      })),
                ),
              ),
              const SizedBox(height: 25),
              Flexible(
                child: QuizElevatedButton(
                  label: Text('Next', style: kBodyText11Style()),
                  backgroundColor: kTeacherPrimaryLightColor,
                  function: () {
                    optionController
                        .changePage(widget.model.data!.questions!.length - 1);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
