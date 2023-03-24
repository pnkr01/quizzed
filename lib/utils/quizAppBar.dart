import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quiz/theme/gradient_theme.dart';

class QuizAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final IconData? leadingIcon;
  final Widget? leading;
  final Widget? tariling;
  final Color? appBarColor;
  const QuizAppbar({
    Key? key,
    required this.titleText,
    this.leadingIcon,
    this.leading,
    this.tariling,
    this.appBarColor,
    required this.preferredSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [if (tariling != null) tariling!],
      elevation: 0,
      backgroundColor: appBarColor ?? whiteColor,
      title: Text(
        titleText,
        style: kAppBarTextStyle().copyWith(fontSize: 18),
      ),
      centerTitle: true,
      leading: leading ??
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            color: whiteColor,
          ),
    );
  }

  @override
  // TODO: implement preferredSize
  final Size preferredSize;
}
