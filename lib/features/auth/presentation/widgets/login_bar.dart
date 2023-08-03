import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/core/theme/app_theme.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/l10n/l10n.dart';

class LogoBar extends StatelessWidget {
  const LogoBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          'assets/lottie/welcome.json',
          width: 200.h,
          height: 200.h,
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          '${context.l10n.wlcomeBack}!',
          style: kHead1Style.copyWith(
            fontSize: 22.sp,
            color: Colors.black,
          ),
        ),
        Text(
          title,
          style: kBody1Style.copyWith(
            height: 1,
            fontSize: 16.sp,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
