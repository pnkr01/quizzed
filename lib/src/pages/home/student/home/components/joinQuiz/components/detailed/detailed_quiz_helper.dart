import 'package:flutter/material.dart';

import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';

class DetailedQuizHelper extends StatelessWidget {
  const DetailedQuizHelper({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 8),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: kQuizLightPrimaryColor,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: kBodyText10Style(),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                overflow: TextOverflow.ellipsis,
                subtitle,
                style: kBodyText12Style(),
              ),
            ],
          ),
        ));
  }
}
