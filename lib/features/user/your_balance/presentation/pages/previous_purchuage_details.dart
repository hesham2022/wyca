import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/features/user/order/presentation/pages/payment_method_page.dart';

class PreviousPurchuageDetails extends StatelessWidget {
  const PreviousPurchuageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        'Package Dry Clean',
        titleColor: ColorName.textColor2,
      ),
      body: Padding(
        padding: kPadding,
        child: Column(
          children: [
             SectionTitile(context.l10n.features),
            const SizedBox(
              height: 20,
            ),
            ...Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child:  FeatureWidget(
                description:
                    'Lorem Ipsum Dolor Sit Amet, Consectetuer Adipiscing Elit, Sed Diam Nonummy',
                title: context.l10n.waterConservation,
                index: 3,
              ),
            ).toList(3),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              h: 36.h,
              title: context.l10n.buyAgain,
              onPressed: () {
                // Navigator.push<void>(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const PaymentMethodPage()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
