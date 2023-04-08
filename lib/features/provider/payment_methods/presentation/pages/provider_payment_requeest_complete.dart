import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/features/provider/home/presentation/pages/provider_home_page.dart';

class ProviderPaymentRequeestComplete extends StatelessWidget {
  const ProviderPaymentRequeestComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, ''),
      body: Padding(
        padding: kPadding,
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Lottie.asset(
              Assets.lottie.animation7,
              height: 178.h,
              width: 178.h,
            ),
            const SizedBox(width: 0, height: 20),
            Text(
              'The Request Has Been Submitted Successfully It Is Under Review',
              textAlign: TextAlign.center,
              style: kSemiBoldStyle.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            const SizedBox(width: 0, height: 30),
            AppButton(
              h: 36.h,
              title: 'Home Page',
              onPressed: () {
                Navigator.pushAndRemoveUntil<void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProviderHomePage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
