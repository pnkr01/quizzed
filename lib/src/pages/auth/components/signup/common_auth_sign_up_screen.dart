import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import '../../../../../theme/app_color.dart';
import '../../../../../utils/quizAppBar.dart';
import '../../controller/common_auth_register_controller.dart';
import 'components/student_components.dart';
import 'components/teacher_components.dart';

class CommomAuthSignUpScreen extends StatefulWidget {
  const CommomAuthSignUpScreen({Key? key}) : super(key: key);
  static const String routeName = '/CommonAuthSignUpScreen';

  @override
  State<CommomAuthSignUpScreen> createState() => _CommomAuthSignUpScreenState();
}

class _CommomAuthSignUpScreenState extends State<CommomAuthSignUpScreen>
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
      length: 2,
      vsync: this,
    );
    //globals.tabController = tabController;
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
    Get.put(CommonAuthSignUpController());
    var myController = Get.find<CommonAuthSignUpController>();

    final tabs = [
      "Student",
      "Teacher",
    ];
    return Container(
      child: Scaffold(
        // bottomSheet: SizedBox(
        //   width: double.infinity,
        //   height: 60,
        //   child: ElevatedButton(
        //       style: ElevatedButton.styleFrom(
        //         shape: const RoundedRectangleBorder(
        //             //  borderRadius: BorderRadius.circular(12), // <-- Radius
        //             ),
        //         backgroundColor: kTeacherPrimaryColor,
        //       ),
        //       onPressed: () {
        //         myController.isRegistering.value = false;
        //         tabIndex.value == 0
        //             ? myController.checkForErrorAndRegisterForStudent()
        //             : myController.checkForErrorAndRegisterForTeacher();
        //         tabIndex.value == 0
        //             ? myController.clearStudentField()
        //             : myController.clearTeacherField();

        //         FocusScope.of(context).unfocus();
        //       },
        //       child: Obx(() => myController.isRegistering.value == true
        //           ? Text(
        //               'Register',
        //               style: kBodyText3Style(),
        //             )
        //           : const Center(
        //               child: CircularProgressIndicator(
        //                 strokeWidth: 1,
        //                 color: whiteColor,
        //               ),
        //             ))),
        // ),
        appBar: const QuizAppbar(
            appBarColor: kTeacherPrimaryColor,
            titleText: 'Quizzed',
            preferredSize: Size.fromHeight(57)),
        //key: _scaffoldKey,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8),
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
                    StudentSignUpScreen(),
                    TeacherSignUpScreen(),
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
