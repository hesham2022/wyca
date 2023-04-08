import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/gen/assets.gen.dart';

class PageWidget extends StatelessWidget {
  const PageWidget({
    super.key,
    required this.title,
    required this.bodyText,
  });
  final String title;
  final String bodyText;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Assets.svg.introPic.svg(
          width: ScreenUtil().setWidth(300),
          height: ScreenUtil().setHeight(300),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              //'DIRTY CAR',
              style: kHead1Style.copyWith(fontSize: 18.sp),
            ),
            Text(
              bodyText,
              style: kBody1Style,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
