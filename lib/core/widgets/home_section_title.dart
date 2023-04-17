import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';

class SectionTitile extends StatelessWidget {
  const SectionTitile(
    this.title, {
    super.key,
    this.color,
  });
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: kHead1Style.copyWith(fontSize: 22.sp, color: color)),
      ],
    );
  }
}
