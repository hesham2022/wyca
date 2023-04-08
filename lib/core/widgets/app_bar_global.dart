import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/theme/app_theme.dart';
import 'package:wyca/gen/assets.gen.dart';

AppBar appBar(BuildContext context, String title,
        {Color? titleColor, Function? back}) =>
    AppBar(
      leadingWidth: 100.sp,
      leading: Padding(
        padding: kPadding.copyWith(top: 0, bottom: 0),
        child: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            if (back != null) {
              back();
              return;
            }
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: Assets.svg.backArrow.svg(
            height: 20.h,
            width: 20.h,
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: kHead1Style.copyWith(
          color: titleColor,
          fontSize: 18.sp,
        ),
      ),
    );
