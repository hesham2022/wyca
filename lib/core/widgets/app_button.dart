import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/theme/app_theme.dart';
import 'package:wyca/gen/colors.gen.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    double? h,
    double? w,
    this.titleColor,
    this.titleStyle,
    this.color = ColorName.primaryColor,
  })  : _h = h ?? 44.h,
        _w = w ?? 302.w;

  final String title;
  final VoidCallback? onPressed;
  final double _h;
  final double _w;
  final Color? color;
  final Color? titleColor;
  final TextStyle? titleStyle;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(
            color: ColorName.primaryColor,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color?>(color),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(
            _w,
            _h,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: titleStyle ??
            kBody1Style.copyWith(
              color: titleColor ?? Colors.white,
              fontSize: 14.sp,
            ),
      ),
    );
  }
}
