// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/imports.dart';

class BighFormField extends StatelessWidget {
  const BighFormField({
    super.key,
    this.fillColor,
    this.controller,
    this.focusNode,
    this.style,
    this.enabled,
    this.hint,
    this.validator,
  });
  final TextEditingController? controller;
  final Color? fillColor;
  final bool? enabled;
  final FocusNode? focusNode;
  final String? hint;
  final String? Function(String?)? validator;

  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      enabled: enabled,
      focusNode: focusNode,
      minLines: 10,
      maxLines: 20,
      controller: controller,
      style: style,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: hint, //'Descripe What  You Feel',
        hintStyle: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xff1AA9A0),
          fontWeight: FontWeight.w400,
        ),
        fillColor: fillColor ?? const Color(0xff1AA9A0).withOpacity(.1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
