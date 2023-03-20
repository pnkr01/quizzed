import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:quiz/src/api/points.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/home/student/controller/student_home_controller.dart';
import 'package:quiz/src/pages/home/student/drawer/components/p&h/privacy_help.dart';
import 'package:quiz/src/pages/home/student/drawer/components/profile/profile_view.dart';
import 'package:quiz/src/pages/home/student/drawer/components/result/result_view.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import '../../../../../utils/size_configuration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../global/shared.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie':
        'Authentication=${sharedPreferences.getString('Scookie') ?? sharedPreferences.getString('Tcookie')}',
    // 'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };
  logoutUser() async {
    try {
      var response = await https.get(
          Uri.parse(ApiConfig.getEndPointsUrl('auth/logout')),
          headers: headers);
      quizDebugPrint(response.body);
      var decode = jsonDecode(response.body);
      //handle logout..
    } on FormatException catch (e) {
      quizDebugPrint('format error');
      showSnackBar(e, redColor, null);
      quizDebugPrint(e);
    } catch (e) {
      showSnackBar(e, redColor, null);
      quizDebugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: kQuizPrimaryColor,
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Image.asset(
                      kLogoPath,
                      width: 100,
                    ),
                    SizedBox(height: 10.h),
                    Column(
                      children: [
                        Text('Hello!', style: kBodyText5Style()),
                        SizedBox(height: 4.h),
                        Text(
                          Get.find<StudentHomeController>().getStudentName(),
                          style: kBodyText4Style(),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const Divider(color: whiteColor),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildMenuItem(
                      text: 'Profile',
                      icon: Icons.person,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    buildMenuItem(
                      text: 'Result',
                      icon: Icons.file_download,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    const Divider(color: whiteColor, thickness: 0.6),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    buildMenuItem(
                      text: 'Privacy & Help',
                      icon: Icons.help,
                      onClicked: () => selectedItem(context, 2),
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    buildMenuItem(
                      text: "Version : 1.0.0",
                      icon: Icons.verified_user_outlined,
                      onClicked: null,
                    ),
                    const Divider(color: whiteColor),
                    buildMenuItem(
                      text: "Logout",
                      icon: Icons.logout,
                      onClicked: () => logoutUser(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getImage() async {
    return '';
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = whiteColor;
    const hoverColor = whiteColor;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
        // size: 28,
      ),
      title: Text(
        text,
        style: kBodyText3Style().copyWith(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Get.to(() => const ProfileScreenView());
        break;
      case 1:
        Get.to(() => const ResultScreenView());
        break;
      case 2:
        Get.toNamed(PrivacyAndHelp.routeName);
        break;
      // if (await sharedPreferences.clear()) {
      //   await FirebaseAuth.instance.signOut();
      //   Get.offAll(const HandleOnBoarding());
      // } else {
      //   Get.snackbar(
      //     'Attendence',
      //     'Unable to logout',
      //     colorText: whiteColor,
      //     backgroundColor: Colors.red,
      //   );
      // }

      // break;
    }
  }
}
