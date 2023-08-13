import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';

import '../controller/support_controller.dart';

class DeveloperCard extends GetView<SupportController> {
  final String name;
  final String bio;
  final String image;
  final String github;
  final String linkedin;
  const DeveloperCard({
    Key? key,
    required this.name,
    required this.bio,
    required this.image,
    required this.github,
    required this.linkedin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: kTeacherPrimaryLightColor,
              child: CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(image),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: kBodyText7Style(),
                ),
                Text(
                  bio,
                  style: kBodyText7Style()
                      .copyWith(color: kTeacherPrimaryLightColor, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                controller.launchURL(github);
              }, icon: const Icon(FontAwesomeIcons.github)),
          IconButton(
              onPressed: () {
                controller.launchURL(linkedin);
              },
              icon: const Icon(
                FontAwesomeIcons.linkedin,
                color: Color(0xff0A66C2),
              )),
        ],
      ),
    );
  }
}
