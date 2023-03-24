import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:quiz/src/model/quiz_details.dart';
import 'package:quiz/theme/app_color.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/shimmer.dart';

class DesignOnTapDetailsQuizComponent extends StatelessWidget {
  const DesignOnTapDetailsQuizComponent({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  final QuizDeatilsModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      margin: const EdgeInsets.only(top: 4),
      color: kTeacherPrimaryLightColor,
      child: SizedBox(
        //height: 250,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.question_img != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const NewsCardSkelton(),
                      imageUrl: '${model.question_img}',
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${index + 1}',
                      style: kBodyText3Style().copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${model.questionStr}',
                      maxLines: 1,
                      style: kBodyText3Style().copyWith(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Options',
                      style: kBodyText1Style(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    ...List.generate(
                      4,
                      (index) => OptionCard(
                        text: model.options![index],
                        ans: model.correctOption!,
                        index: index,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.text,
    required this.ans,
    required this.index,
  }) : super(key: key);
  final String text;
  final int ans;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: ans == index ? const Color.fromARGB(255, 202, 243, 154) : null,
      ),
      child: Center(
        child: Padding(
          padding: ans == index
              ? const EdgeInsets.all(8.0)
              : const EdgeInsets.all(4),
          child: Text(text,
              maxLines: 1,
              style: kBodyText3Style().copyWith(
                  color: ans == index ? kTeacherPrimaryColor : whiteColor)),
        ),
      ),
    );
  }
}
