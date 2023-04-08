import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/app_dropdownfield.dart';
import 'package:wyca/gen/colors.gen.dart';

extension AppFormField on TextFormField {
  Widget commonFild(BuildContext context) {
    return SizedBox(
      // height: kTextFieldHeight,
      child: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
                subtitle1: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xff363636),
                    ),
              ),
          inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
                hintStyle: kBody1Style.copyWith(
                  fontSize: 14.sp,
                  color: const Color(0xff363636),
                ),
              ),
        ),
        child: this,
      ),
    );
  }

  Widget commonFild2(BuildContext context) {
    return SizedBox(
      // height: kTextFieldHeight,
      child: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
                subtitle1: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xff363636),
                    ),
              ),
          inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          
                focusedBorder: kOutlinePrimaryColor,
                enabledBorder: kOutlinePrimaryColor,
                disabledBorder: kOutlinePrimaryColor,
                errorBorder: kOutlinePrimaryColor,
                focusedErrorBorder: kOutlinePrimaryColor,
                border: kOutlinePrimaryColor,
                hintStyle: kBody1Style.copyWith(
                  color: ColorName.primaryColor,
                  fontSize: 14.sp,
                ),
              ),
        ),
        child: this,
      ),
    );
  }
}

//  TextFormField(
//             controller: controller,
//             decoration: InputDecoration(
//               hintText: 'Enter your $hint',
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(
//                   color: ColorName.primaryColor,
//                 ),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(
//                   color: ColorName.primaryColor,
//                 ),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(
//                   color: ColorName.primaryColor,
//                 ),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//           )

extension AppDropDownFormField on AppDropDownField {
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
              subtitle1: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 14.sp,
                    color: const Color(0xff363636),
                  ),
            ),
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              hintStyle: kBody1Style.copyWith(
                fontSize: 14.sp,
                color: const Color(0xff363636),
              ),
            ),
      ),
      child: this,
    );
  }
}
//AppDropDownField