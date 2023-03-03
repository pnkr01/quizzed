import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/utils/size_configuration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color first = Color(0xff2FA4D4);
//const Color second = Color(0xff345DDB);
const Color third = Color(0xff2BF0CD);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
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
      color: Colors.white, fontSize: getProportionateScreenHeight(12.0.sp));
}

TextStyle kBodyText1Style() {
  return GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: getProportionateScreenHeight(14.0.sp),
    fontWeight: FontWeight.w700,
  );
}

TextStyle kAppBarTextStyle() {
  return GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kBodyText2Style() {
  return GoogleFonts.montserrat(
    fontSize: getProportionateScreenHeight(16.0.sp),
    fontWeight: FontWeight.w500,
    // color: Colors.white,
  );
}

TextStyle kBodyText3Style() {
  return GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontSize: getProportionateScreenHeight(12.0.sp),
  );
}
TextStyle kElevatedButtonTextStyle() {
  return GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontSize: 14.sp,
  );
}

TextStyle kSubTitleTextStyle() {
  return GoogleFonts.nunito(
      color: Colors.white, fontSize: getProportionateScreenHeight(12.0.sp));
}
