import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/db/firebase/firebase_helper.dart';
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
    slides = MyFirebase.storeCollection.snapshots().map(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.dstATop),
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
                              style: kBodyText1Style()
                                  .copyWith(color: kPrimaryColor)),
                          Flexible(
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                                controller.getStudentName(),
                                style: kBodyText1Style()
                                    .copyWith(color: kPrimaryColor)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          Text('Regd  : ',
                              style: kBodyText1Style()
                                  .copyWith(color: kPrimaryColor)),
                          Flexible(
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                                controller.getStudentregdNo(),
                                style: kBodyText1Style()
                                    .copyWith(color: kPrimaryColor)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          Text('Phone : ',
                              style: kBodyText1Style()
                                  .copyWith(color: kPrimaryColor)),
                          Flexible(
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                                controller.getStudentPhone(),
                                style: kBodyText1Style()
                                    .copyWith(color: kPrimaryColor)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      )
                    ],
                  ),
                ),
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
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(cornerRadius),
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
                padding: EdgeInsets.symmetric(horizontal: 0.h),
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
                            color: Color.fromARGB(255, 6, 112, 9),
                          ),
                          Text('Join Quiz',
                              style: kElevatedButtonTextStyle().copyWith(
                                  color: const Color.fromARGB(255, 6, 112, 9)))
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
