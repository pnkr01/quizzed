import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/my_global.dart' as globals;
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/components/completed_quiz.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/components/draft_quiz.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/components/live_quiz.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/controller/draft_quiz_controller.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/controller/live_quiz_controller.dart';
import 'package:quiz/src/pages/home/teacher/home/components/allQuiz/design/controller/completed_controller.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';

import '../../../../../../../theme/app_color.dart';

class ShowAllCreatedQuiz extends StatefulWidget {
  const ShowAllCreatedQuiz({Key? key}) : super(key: key);
  static const String routeName = '/showAllQuizScreen';

  @override
  State<ShowAllCreatedQuiz> createState() => _ShowAllCreatedQuizState();
}

class _ShowAllCreatedQuizState extends State<ShowAllCreatedQuiz>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    globals.tabController = tabController;
    tabController.addListener(() {
      setState(() {
        tabIndex.value = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  Get.put(ShowAllQuizCOntroller());

    final tabs = [
      "Draft",
      "Live",
      "Completed",
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            tabIndex.value == 2 ? greenColor : kTeacherPrimaryColor,
        onPressed: () {
          if (tabIndex.value == 0) {
            //draftcontroller.
            log('inside draft refresh');
            Get.find<DraftQuizController>().isFetching.value = true;
            Get.find<DraftQuizController>().fetchDraftQuiz();
          } else if (tabIndex.value == 1) {
            //liver controller.
            Get.find<LiveQuizController>().isFetching.value = true;
            Get.find<LiveQuizController>().fetchLiveQuiz();
            log('inside live refresh');
          } else {
            //completed controller.
            Get.find<CompletedQuizController>().isFetching.value = true;
            log('inside completed refresh');
            Get.find<CompletedQuizController>().completedQuizFetch();
          }
        },
        child: const Icon(Icons.refresh),
      ),
      appBar: const QuizAppbar(
          appBarColor: kTeacherPrimaryColor,
          titleText: 'Quizzed',
          preferredSize: Size.fromHeight(57)),
      //key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TabBar(
                  controller: tabController,
                  isScrollable: false,
                  // give the indicator a decoration (color and border radius)
                  indicator: const BoxDecoration(
                    color: kTeacherPrimaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(99.0),
                    ),
                  ),
                  labelColor: Colors.white,
                  labelStyle: kBodyText1Style().copyWith(
                    fontSize: 14.0,
                  ),
                  unselectedLabelColor: kTeacherPrimaryLightColor,
                  tabs: [
                    for (final tab in tabs)
                      Tab(
                        text: tab,
                      ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    // upComingEvent(),
                    DraftQuizScreen(),
                    LiveQuizScreen(),
                    CompletedQuizScreen()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
