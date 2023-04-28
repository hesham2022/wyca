import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// import screenUtil library
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/theme/colors.dart';
import 'package:wyca/gen/colors.gen.dart';

final kTextFieldHeight = 50.h;
final kHead1Style = TextStyle(
  fontSize: 20.sp,
  color: ColorName.primaryColor,
  fontWeight: FontWeight.bold,
);
final kSemiBoldStyle = TextStyle(
  fontSize: 20.sp,
  color: ColorName.primaryColor,
  fontWeight: FontWeight.w600,
);
final kBody1Style = TextStyle(
  fontSize: 14.sp,
  color: ColorName.textColor2,
);
// add Theme configraiton
final kOutlinePrimaryColor = OutlineInputBorder(
  borderSide: const BorderSide(
    color: ColorName.primaryColor,
  ),
  borderRadius: BorderRadius.circular(4),
);
final theme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.all(12.5.sp),
    suffixIconColor: ColorName.primaryColor,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    hintStyle: kHead1Style.copyWith(fontSize: 12.sp),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff3636364d), width: 2),
      borderRadius: BorderRadius.circular(4),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff3636364d), width: 2),
      borderRadius: BorderRadius.circular(4),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff3636364d), width: 2),
      borderRadius: BorderRadius.circular(4),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff3636364d), width: 2),
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  primaryColor: kPrimaryColor,
  fontFamily: 'Cairo',
  textTheme: TextTheme(
    button: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
  buttonTheme: const ButtonThemeData(
      // buttonColor: Colors.white,
      // textTheme: ButtonTextTheme.primary,
      // shape: CircleBorder(),
      //  RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(4),
      // ),
      ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xff000000)),
    color: Colors.white,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Cairo',
      color: ColorName.textColor3,
      fontWeight: FontWeight.w700,
      fontSize: 22,
    ),
    elevation: 0,
  ),
  colorScheme: const ColorScheme.light(
    primary: ColorName.primaryColor,

    // onPrimary: kPrimaryLightColor,
    // secondary: kSecondaryColor,
    // onSecondary: kSecondaryLightColor,
    // surface: kSurfaceColor,
    // onSurface: kSurfaceLightColor,
    // background: kBackgroundColor,
    // onBackground: kBackgroundLightColor,
    // error: kErrorColor,
    // onError: kErrorLightColor,
    // brightness: Brightness.light,
  ),
);
final kPadding = EdgeInsets.only(left: 36.sp, right: 36.sp, top: 36.sp);

const primaryColor = Color(0xff0A84E1);
const seocondColor = Color(0xff1AA9A0);
final textStyleWithPrimaryBold = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
  color: primaryColor,
);
final textStyleWithPrimarySemiBold = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.w400,
  color: primaryColor,
);

TextStyle textStyleWithSecondBold({double? s}) => TextStyle(
      fontSize: s ?? 20.sp,
      fontWeight: FontWeight.bold,
      color: seocondColor,
    );
final textStyleWithSecondSemiBold = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.w400,
  color: seocondColor,
);

Widget autoSizeText({
  required String text,
  int maxLines = 1,
  FontWeight fontWeight = FontWeight.w500,
  Color color = Colors.black,
  TextDecoration decoration = TextDecoration.none,
  double size = 20,
}) {
  return AutoSizeText(
    text,
    style: TextStyle(
      fontSize: size,
      fontFamily: 'Cairo',
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
      height: 1.3,
    ),
    minFontSize: size,
    maxFontSize: size,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
  );
}
