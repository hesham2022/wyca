import 'package:flutter/material.dart';
import 'package:wyca/features/provider/payment_methods/presentation/pages/provider_payment_requeest_complete.dart';
import 'package:wyca/features/user/order/presentation/widgets/location_item.dart';
import 'package:wyca/imports.dart';

enum ProviderPaymentWayes {
  vodafone,
  bankAccount,
  none,
}

class ProviderPaymentMethods extends StatefulWidget {
  const ProviderPaymentMethods({super.key});

  @override
  State<ProviderPaymentMethods> createState() => _ProviderPaymentMethodsState();
}

class _ProviderPaymentMethodsState extends State<ProviderPaymentMethods> {
  String _currentPaymentWay = ProviderPaymentWayes.none.toString();
  bool next = false;
  Widget _paymentMethodWidget() {
    return Column(
      children: [
        AppRadioListTile(
          title: 'Vodafone Cash',
          value: ProviderPaymentWayes.vodafone.toString(),
          onChanged: (value) {
            setState(() {
              _currentPaymentWay = value!;
            });
          },
          groupValue: _currentPaymentWay.toString(),
          leadingIcon: const Icon(
            Icons.payment,
            color: ColorName.primaryColor,
          ),
        ),
        AppRadioListTile(
          title: 'Bank Account',
          value: ProviderPaymentWayes.bankAccount.toString(),
          onChanged: (value) {
            setState(() {
              _currentPaymentWay = value!;
            });
          },
          groupValue: _currentPaymentWay,
          leadingIcon: const Icon(
            Icons.account_balance_outlined,
            color: ColorName.primaryColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, context.l10n.paymentMethods),
      body: Padding(
        padding: kPadding,
        child: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: showedWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget showedWidget() {
    if (_currentPaymentWay == ProviderPaymentWayes.vodafone.toString() &&
        next == true) return _vodafoneWidget();
    if (_currentPaymentWay == ProviderPaymentWayes.bankAccount.toString() &&
        next == true) return _bankAccountWidget();
    return _startet_widget();
  }

  Widget _bankAccountWidget() {
    return Column(
      children: [
        const SectionTitile('Bank Account'),
        SizedBox(
          height: 15.h,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintStyle: kBody1Style.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xff363636),
                  ),
                  hintText: 'Countery',
                  // suffixText: 'Submit',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintStyle: kBody1Style.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xff363636),
                  ),
                  hintText: 'City',
                  // suffixText: 'Submit',
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: kBody1Style.copyWith(
              fontSize: 12.sp,
              color: const Color(0xff363636),
            ),
            hintText: 'Bank Name',
            // suffixText: 'Submit',
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: kBody1Style.copyWith(
              fontSize: 12.sp,
              color: const Color(0xff363636),
            ),
            hintText: 'Branch Address',
            // suffixText: 'Submit',
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: kBody1Style.copyWith(
              fontSize: 12.sp,
              color: const Color(0xff363636),
            ),
            hintText: "Account Holder's Name",
            // suffixText: 'Submit',
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: kBody1Style.copyWith(
              fontSize: 12.sp,
              color: const Color(0xff363636),
            ),
            hintText: 'Account Number',
            // suffixText: 'Submit',
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: kBody1Style.copyWith(
              fontSize: 12.sp,
              color: const Color(0xff363636),
            ),
            hintText: 'Account Holder Address',
            // suffixText: 'Submit',
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        AppButton(
          title: 'PAYMENT REQUEST',
          h: 36.h,
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => const ProviderPaymentRequeestComplete(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _vodafoneWidget() {
    return Column(
      children: [
        const SectionTitile('Vodafone Cash'),
        SizedBox(
          height: 15.h,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintStyle: kBody1Style.copyWith(
              fontSize: 12.sp,
              color: const Color(0xff363636),
            ),
            hintText: 'Name',
            // suffixText: 'Submit',
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintStyle: kBody1Style.copyWith(
              fontSize: 12.sp,
              color: const Color(0xff363636),
            ),
            hintText: 'Mobile Number',

            // suffixText: 'Submit',
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        AppButton(
          h: 36.h,
          title: 'Payment Request',
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (context) => const ProviderPaymentRequeestComplete(),
              ),
            );
          },
        ),
      ],
    );
  }

  Column _startet_widget() {
    return Column(
      children: [
        const SectionTitile('Payment Method'),
        SizedBox(
          height: 20.h,
        ),
        _paymentMethodWidget(),
        const SizedBox(
          height: 20,
        ),
        AppButton(
          h: 36.h,
          title: 'Next',
          onPressed: () {
            setState(() {
              next = true;
            });
          },
        ),
      ],
    );
  }
}
