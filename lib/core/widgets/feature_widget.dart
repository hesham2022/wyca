import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({
    super.key,
    required this.description,
    required this.title,
    this.isOrderedList = true,
    this.titleColor,
    required this.index,
  });
  final int index;
  final String title;
  final String description;
  final bool isOrderedList;
  final Color? titleColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isOrderedList)
          Container(
            height: 24.h,
            width: 24.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorName.textColor3,
            ),
            child: Center(
              child: Text(
                '1',
                style: kHead1Style.copyWith(
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (isOrderedList)
          SizedBox(
            width: 10.w,
          ),
        if (index.isEven && !isOrderedList) Assets.svg.hand.svg(height: 60),
        if (index.isEven && !isOrderedList)
          SizedBox(
            width: 10.w,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kSemiBoldStyle.copyWith(
                fontSize: 14.sp,
                color: titleColor ?? Colors.black,
              ),
            ),
            SizedBox(
              width: 220.w,
              child: Text(
                description,
                textAlign: TextAlign.start,
              ),
            )
          ],
        ),
        if (index.isOdd && !isOrderedList)
          SizedBox(
            width: 10.w,
          ),
        if (index.isOdd && !isOrderedList) Assets.svg.hand.svg(),
      ],
    );
  }
}
