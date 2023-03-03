import 'package:flutter/material.dart';
import 'package:quiz/theme/app_color.dart';

import '../../../../../utils/size_configuration.dart';

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
                    SizedBox(height: getProportionateScreenHeight(50)),
                    GestureDetector(
                      onTap: () {
                        // log('tap');
                        // sharedPreferences.remove('1');
                        // requestImg();
                      },
                      child: CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          radius: 60,
                          child: Container()),
                    ),

                    SizedBox(height: getProportionateScreenHeight(20)),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Text(
                    //     sharedPreferences.getString('studentName')!,
                    //     style: kTextStyle().copyWith(
                    //       fontSize: 18.0,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const Divider(color: Colors.white70),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    buildMenuItem(
                      text: 'College Result',
                      icon: Icons.person,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    buildMenuItem(
                      text: 'Semester Attendence',
                      icon: Icons.add,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    buildMenuItem(
                      text: 'PPT History',
                      icon: Icons.update,
                      onClicked: () => selectedItem(context, 2),
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    const Divider(color: Colors.white70),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    buildMenuItem(
                      text: 'Privacy & Help',
                      icon: Icons.help,
                      onClicked: () => selectedItem(context, 3),
                    ),
                    SizedBox(height: getProportionateScreenHeight(16)),
                    // buildMenuItem(
                    //   text: "Version : $version",
                    //   icon: Icons.verified_user_outlined,
                    //   onClicked: null,
                    // ),
                    const Divider(color: Colors.white70),
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
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        //   Get.to(() => const Result());

        //   // Get.to(
        //   //   () => sharedPreferences.getBool('isServerLive')!
        //   //       ? const Result()
        //   //       : () => Get.snackbar(
        //   //             'Attendence App',
        //   //             "College Server is Down",
        //   //             colorText: Colors.white,
        //   //             backgroundColor: Colors.red,
        //   //           ),
        //   //);
        //   break;
        // case 1:
        //   Get.to(() => const CollegeAttendence());
        //   break;
        // case 2:
        //   Get.to(() => const PPTHistory());
        //   break;
        // case 3:
        //   Get.to(() => const PrivacyAndHelpScreen());
        // if (await sharedPreferences.clear()) {
        //   await FirebaseAuth.instance.signOut();
        //   Get.offAll(const HandleOnBoarding());
        // } else {
        //   Get.snackbar(
        //     'Attendence',
        //     'Unable to logout',
        //     colorText: Colors.white,
        //     backgroundColor: Colors.red,
        //   );
        // }

        break;
    }
  }
}
