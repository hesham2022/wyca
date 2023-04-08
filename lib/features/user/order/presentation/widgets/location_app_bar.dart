import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/global_data.dart';

class LocationAppBar extends StatelessWidget {
  const LocationAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding,
      child: Row(
        children: [
          Flexible(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
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

          // Flexible(
          //   flex: 5,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'Location',
          //         style: kBody1Style.copyWith(fontSize: 10.sp),
          //       ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             kLocations.last,
          //             style: kSemiBoldStyle.copyWith(fontSize: 10.sp),
          //           ),
          //           Icon(
          //             Icons.arrow_drop_down,
          //             size: 15.sp,
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          
          Flexible(child: Container())
          // const Spacer(),
        ],
      ),
    );
  }
}
