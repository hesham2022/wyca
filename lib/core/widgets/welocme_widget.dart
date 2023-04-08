import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/l10n/l10n.dart';

class WelcomWidget extends StatelessWidget {
  const WelcomWidget({
    super.key,
    this.name,
  });
  final String? name;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 30.sp,
            ),
            children: [
              TextSpan(
                text: '${context.l10n.hello}, ',
                style: kSemiBoldStyle.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              TextSpan(
                text: name ?? ' Helal,',
                style: kBody1Style.copyWith(
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
