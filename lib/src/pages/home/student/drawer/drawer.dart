import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/strings.dart';
import 'package:quiz/src/pages/home/student/controller/student_home_controller.dart';
import 'package:quiz/src/pages/home/student/drawer/components/p&h/privacy_help.dart';
import 'package:quiz/src/pages/home/student/drawer/components/profile/profile_view.dart';
import 'package:quiz/src/pages/home/student/drawer/components/result/result_view.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import '../../../../../utils/size_configuration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: kPrimaryColor,
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
      // case 3:
      //   Get.to(() => const PrivacyAndHelpScreen());
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
