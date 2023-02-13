import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/utils/size_configuration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color first = Color(0xff2FA4D4);
//const Color second = Color(0xff345DDB);
const Color third = Color(0xff2BF0CD);
//const Color fourth = Color(0xff010D4D);

class GradientClass {
  static List<Color> getLinearGradient() {
    return [
      first,
      third,
    ];
  }
}

TextStyle kTitleTextStyle() {
  return GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: getProportionateScreenHeight(12.0.sp)
  );
}

TextStyle kSubTitleTextStyle() {
  return GoogleFonts.nunito(
    color: Colors.white,
    fontSize: getProportionateScreenHeight(12.0.sp)
  );
}