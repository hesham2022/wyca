import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';

class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Terms and Conditions'),
      body: Padding(
        padding: kPadding,
        child: Column(
          children: <Widget>[
            const SectionTitile('This Text Is An Example Of A Text That Can'),
            SizedBox(height: 10.h),
            Text(
              'Lorem Ipsum Dolor Sit Amet, Consectetuer Adipiscing Elit, Sed Diam Nonummy Lorem Ipsum Dolor Sit Amet,Consectetuer Adipiscing Elit, Sed',
              style:
                  kSemiBoldStyle.copyWith(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            const SectionTitile('This Text Is An Example Of A Text That Can'),
            SizedBox(height: 10.h),
            Text(
              'Lorem Ipsum Dolor Sit Amet, Consectetuer Adipiscing Elit, Sed Diam Nonummy Lorem Ipsum Dolor Sit Amet,Consectetuer Adipiscing Elit, Sed',
              style:
                  kSemiBoldStyle.copyWith(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            const SectionTitile('This Text Is An Example Of A Text That Can'),
            SizedBox(height: 10.h),
            Text(
              'Lorem Ipsum Dolor Sit Amet, Consectetuer Adipiscing Elit, Sed Diam Nonummy Lorem Ipsum Dolor Sit Amet,Consectetuer Adipiscing Elit, Sed',
              style:
                  kSemiBoldStyle.copyWith(color: Colors.black, fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            const VedioWidget()
          ],
        ),
      ),
    );
  }
}
