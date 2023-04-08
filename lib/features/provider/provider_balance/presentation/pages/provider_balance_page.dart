import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/provider/payment_methods/presentation/pages/provider_payment_methods.dart';
import 'package:wyca/imports.dart';

class ProviderBalancePage extends StatelessWidget {
  const ProviderBalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final balance = context.read<AuthenticationBloc>().state.provider!.balance;
    return Scaffold(
      appBar: appBar(
        context,
        context.l10n.balance,
      ),
      body: Padding(
        padding: kPadding,
        child: Column(
          children: [
            Row(
              children: [
                Lottie.asset(
                  Assets.lottie.animation8,
                  height: 18.h,
                  width: 18.h,
                ),
                const SizedBox(width: 2),
                SectionTitile(context.l10n.note),
              ],
            ),
            Text(
              'Lorem Ipsum Dolor Sit Amet, Consectetuer Adipiscing Elit, Sed Diam Nonummy',
              style:
                  kHead1Style.copyWith(fontSize: 12.sp, color: ColorName.black),
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.balance,
              style: kHead1Style.copyWith(fontSize: 16.sp),
            ),
            Lottie.asset(
              Assets.lottie.animation6,
              height: 86.h,
              width: 86.h,
            ),
            Text('$balance LE', style: kHead1Style.copyWith(fontSize: 30.sp)),
            SizedBox(height: 20.h),
            AppButton(
              h: 36.h,
              title: context.l10n.paymentRequest,
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProviderPaymentMethods(),
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            SectionTitile(
              context.l10n.paymentHistory,
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Convert 50 Egyptian Pounds',
                            style: kHead1Style.copyWith(
                              fontSize: 12.sp,
                              color: ColorName.black,
                            ),
                          ),
                          Text(
                            '21-5-2022',
                            style: kHead1Style.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        index.isEven
                            ? context.l10n.approved
                            : context.l10n.pending,
                        style: kHead1Style.copyWith(fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
