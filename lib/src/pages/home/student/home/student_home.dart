import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/pages/home/student/controller/student_home_controller.dart';
import 'package:quiz/src/pages/home/student/home/components/quizElevatedButon.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../drawer/drawer.dart';
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
    slides = FirebaseFirestore.instance.collection('store').snapshots().map(
          (list) => list.docs.map(
            (doc) => doc.data(),
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    _querydb();
  }

  @override
  Widget build(BuildContext context) {
    //Get.put(() => StudentHomeController());
    var controller = Get.find<StudentHomeController>();
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
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
              onPressed: () {},
              icon: const Icon(Icons.notifications_active_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
              height: 120.h,
            ),
            SizedBox(
              height: 8.h,
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(cornerRadius),
                                  color: whiteColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: index['img'],
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      placeholder: (context, url) => Container(
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            color: kPrimaryColor,
                                          ),
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
                            const Duration(milliseconds: 500),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.h),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  QuizElevatedButton(
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.keyboard_double_arrow_right_outlined,
                          color: greenColor,
                        ),
                        Text('Join Quiz',
                            style: kElevatedButtonTextStyle()
                                .copyWith(color: greenColor))
                      ],
                    ),
                    backgroundColor: const Color.fromARGB(255, 200, 249, 199),
                    function: () {
                      controller.navigateToJoinQuiz();
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
                          Icons.bolt,
                          color: redColor,
                        ),
                        Text('Result',
                            style: kElevatedButtonTextStyle()
                                .copyWith(color: redColor))
                      ],
                    ),
                    backgroundColor: const Color(0xFFF9D8D6),
                    function: () {
                      controller.navigateToResultQuiz();
                    },
                  )
                ],
              ),
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
            color: Colors.indigo,
            rotationAngle: 180,
            verticalOffset: -10,
            borderRadius: BorderRadius.circular(24),
          ),
          inActiveColorOverride: (i) => Colors.white,
        ),
      );
}
