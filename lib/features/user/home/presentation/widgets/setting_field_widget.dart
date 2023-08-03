import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/features/auth/presentation/widgets/password_field.dart';

class SettingFieldWidget extends StatelessWidget {
  const SettingFieldWidget({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
  });
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: kSemiBoldStyle.copyWith(
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        if (isPassword)
          PasswordField(
            controller: controller,
          )
        else
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter your $hint',
              fillColor: ColorName.secondaryColor,
              filled: true,
              enabled: true,
              hintStyle: TextStyle(color: ColorName.primaryColor),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ).commonFild(context),
      ],
    );
  }
}
