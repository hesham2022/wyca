import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/features/provider/branches/presentation/pages/branches_page.dart';
import 'package:wyca/features/provider/home/presentation/pages/provider_home_page.dart';

class ProviderSuccessSignUp extends StatelessWidget {
  const ProviderSuccessSignUp({super.key});

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
              'Go To The Nearest Wyca Branch To Receive Washing Materials And Learn How To Wash Easily And To Activate Your Account',
              textAlign: TextAlign.center,
              style: kSemiBoldStyle.copyWith(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
            const SizedBox(width: 0, height: 30),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    h: 36.h,
                    title: 'Branches',
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BranchesPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: AppButton(
                    color: Colors.white,
                    titleColor: ColorName.primaryColor,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
