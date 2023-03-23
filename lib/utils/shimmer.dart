import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_color.dart';
import '../theme/gradient_theme.dart';

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: greyColor.withOpacity(0.8),
      highlightColor: whiteColor.withOpacity(0.6),
      period: const Duration(seconds: 2),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 200,
          width: Get.width,
          decoration: BoxDecoration(
              color: greyColor.withOpacity(0.25),
              borderRadius: const BorderRadius.all(Radius.circular(24))),
        ),
      ),
    );
  }
}
