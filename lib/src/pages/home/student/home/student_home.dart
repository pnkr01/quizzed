import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/db/firebase/firebase_helper.dart';
import 'package:quiz/src/db/local/local_db.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quiz/src/pages/home/student/controller/student_home_controller.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../utils/quizElevatedButon.dart';
import '../../../../global/shared.dart';
import '../../../../model/past_quiz_model.dart';
import '../drawer/drawer.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});
  static const String routeName = '/studentHome';

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  double cornerRadius = 12.0;
  int? activeIndex = 0;
  Stream? slides;
  List? slideList;
  _querydb() {
    slides = MyFirebase.storeCollection.snapshots().map(
          (list) => list.docs.map(
            (doc) => doc.data(),
          ),
        );
  }

  List<PastQuizModel> pastQuiz = [];
  bool isPastQuizLoading = true;

  fetchPastQuiz() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Cookie': 'Authentication=${sharedPreferences.getString('Scookie')}',
      // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    final url = ApiConfig.getEndPointsNextUrl('quiz/getall');
    final uri = Uri.parse(url);
    final response = await https.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      for (var obj in json) {
        quizDebugPrint(obj.toString());
        pastQuiz.add(PastQuizModel.fromJson(obj));
        //_startTimer();
      }
      quizDebugPrint(pastQuiz);
      if (mounted) {
        setState(() {
          isPastQuizLoading = !isPastQuizLoading;
        });
      }
    } else {
      //unexoected result
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      LocalDB.removeLoacalDb();
      showSnackBar('Session Expired :(', kTeacherPrimaryColor, whiteColor);
    }
  }

  @override
  void initState() {
    super.initState();
    _querydb();
    try {
      fetchPastQuiz();
    } catch (e) {
      Get.offAllNamed(CommmonAuthLogInRoute.routeName);
      LocalDB.removeLoacalDb();
      showSnackBar('Session Expired :(', blackColor, whiteColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(() => StudentHomeController());
    var controller = Get.find<StudentHomeController>();
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      backgroundColor: kQuizPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kQuizPrimaryColor,
        centerTitle: true,
        title: Text(
          'Quizzed',
          style: kAppBarTextStyle(),
        ),
        leading: Builder(
            builder: ((context) => InkWell(
                  child: const Icon(Icons.menu),
                  onTap: () => Scaffold.of(context).openDrawer(),
                ))),
        actions: [
          IconButton(
              onPressed: () {
                quizDebugPrint('logout');
                LocalDB.removeLoacalDb();
                Get.offAllNamed(CommmonAuthLogInRoute.routeName);
                //sharedPreferences.remove('SOAQZ2023_2');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              userInfoCard(controller),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder(
                stream: slides,
                builder: (context, AsyncSnapshot snap) {
                  if (snap.hasError) {
                    const Center(
                      child: CircularProgressIndicator(
                        color: whiteColor,
                      ),
                    );
                  }
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        const Center(
                          child: CircularProgressIndicator(
                            color: whiteColor,
                          ),
                        ),
                      ],
                    );
                  }
                  slideList = snap.data.toList();
                  return Stack(
                    children: [
                      CarouselSlider(
                        items: slideList!.map(
                          (index) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(cornerRadius),
                                    color: whiteColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: index['img'],
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(
                              () {
                                activeIndex = index;
                              },
                            );
                          },
                          pauseAutoPlayOnManualNavigate: true,
                          height: MediaQuery.of(context).size.height * 0.3,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width / 3.5,
                        right: MediaQuery.of(context).size.width / 2,
                        child: buildIndicator(),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                margin: const EdgeInsets.only(left: 2),
                child: Text(
                  'Your past Quiz',
                  style: kBodyText3Style(),
                ),
              ),
              const SizedBox(height: 8),
              isPastQuizLoading
                  ? Container(
                      margin: EdgeInsets.only(left: 2, top: 8.h),
                      decoration: const BoxDecoration(
                        color: whiteColor,
                        //borderRadius: BorderRadius.circular(cornerRadius),
                      ),
                      height: 180,
                      width: double.infinity,
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: kTeacherPrimaryColor,
                      )),
                    )
                  : pastQuiz.isNotEmpty
                      ? Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ListView.builder(
                              itemCount: pastQuiz.length,
                              itemBuilder: (context, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                          child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Quiz ID : ${pastQuiz[index].quizId!}',
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Completed : ${pastQuiz[index].completed!}',
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Started At : ${DateFormat('dd-MM-yyyy ').add_jm().format(DateTime.tryParse(pastQuiz[index].startTime!)!)}',
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Ended At : ${DateFormat('dd-MM-yyyy ').add_jm().format(DateTime.tryParse(pastQuiz[index].finishTime!)!)}',
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Attempted Qs : ${pastQuiz[index].questionsAttemptedDetails!}',
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      )),
                                    ],
                                  )),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 2, top: 8.h),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(cornerRadius),
                          ),
                          height: 180,
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              'No Past Quiz',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  QuizElevatedButton(
                    isBorderColorRequired: true,
                    borderColor: kTeacherPrimaryColor,
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: kTeacherPrimaryColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text('Join Quiz', style: kBodyText1Style())
                      ],
                    ),
                    backgroundColor: kQuizButtonLightColor,
                    function: () {
                      //check for DND Services.
                      //if not enabled then ask to enabled.
                      controller.checkDND();
                      //controller.navigateToJoinQuiz();
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  QuizElevatedButton(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.task,
                          color: kTeacherPrimaryColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text('Result', style: kBodyText1Style())
                      ],
                    ),
                    backgroundColor: kQuizButtonLightColor,
                    function: () {
                      controller.navigateToResultQuiz();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container userInfoCard(StudentHomeController controller) {
    return Container(
      margin: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.0), BlendMode.dstATop),
          image: const AssetImage('assets/images/fade.png'),
          fit: BoxFit.cover,
        ),
        color: whiteColor,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      //height: 120.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 6, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Name : ',
                    style: kBodyText1Style().copyWith(color: darkJoinColor)),
                Flexible(
                  child: Text(
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                      controller.getStudentName(),
                      style: kBodyText1Style().copyWith(color: darkJoinColor)),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Text('Regd  : ',
                    style: kBodyText1Style().copyWith(color: darkJoinColor)),
                Flexible(
                  child: Text(
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                      controller.getStudentregdNo(),
                      style: kBodyText1Style().copyWith(color: darkJoinColor)),
                ),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Text('Phone : ',
                    style: kBodyText1Style().copyWith(color: darkJoinColor)),
                Flexible(
                  child: Text(
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                      controller.getStudentPhone(),
                      style: kBodyText1Style().copyWith(color: darkJoinColor)),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex!,
        count: slideList!.length,
        effect: CustomizableEffect(
            dotDecoration: DotDecoration(
              width: 24,
              height: 12,
              color: Colors.green,
              borderRadius: BorderRadius.circular(16),
              verticalOffset: 0,
            ),
            activeDotDecoration: DotDecoration(
              width: 32,
              height: 12,
              color: kQuizPrimaryColor,
              rotationAngle: 180,
              verticalOffset: -10,
              borderRadius: BorderRadius.circular(24),
            ),
            inActiveColorOverride: (i) => whiteColor),
      );
}
