import 'package:flutter/material.dart';
import 'package:wyca/global_data.dart';
import 'package:wyca/imports.dart';

final _fromKey = GlobalKey<FormState>();

class AddNewPaymentCrd extends StatefulWidget {
  const AddNewPaymentCrd({super.key});

  @override
  State<AddNewPaymentCrd> createState() => _AddNewPaymentCrdState();
}

class _AddNewPaymentCrdState extends State<AddNewPaymentCrd> {
  final expiryDateController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cvvController = TextEditingController();
  final nameOnCardController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(
          context,
          context.l10n.paymentMethods,
        ),
        body: Form(
          key: _fromKey,
          child: Padding(
            padding: kPadding,
            child: Column(
              children: [
                SectionTitile(context.l10n.addCreditCard),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  controller: nameOnCardController,
                  validator: (value) => value!.isEmpty ? 'Please enter your card Name' : null,
                  decoration: const InputDecoration(
                    hintText: 'Name on the Card',
                  ),
                ).commonFild(context),
                SizedBox(
                  height: 12.h,
                ),
                TextFormField(
                  controller: cardNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your card number';
                    }
                    if (value.length < 16) {
                      return 'Please enter valid card number';
                    }

                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Card Number',
                  ),
                  keyboardType: TextInputType.number,
                ).commonFild(context),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your card expiry date';
                          }
                          if (value.length < 5) {
                            return 'Please enter valid card expiry date';
                          }

                          return null;
                        },
                        controller: expiryDateController,
                        onChanged: (value) {
                          if (value.length == 2) {
                            expiryDateController.text = '/${expiryDateController.text}';
                          } //<-- Automatically show a '/' after dd
                        },
                        decoration: const InputDecoration(
                          hintText: 'Period',
                        ),
                        keyboardType: TextInputType.number,
                      ).commonFild(context),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: cvvController,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your card CVV'
                            : value.length < 3
                                ? 'Please enter valid card CVV'
                                : null,
                        decoration: const InputDecoration(
                          hintText: 'CVV',
                        ),
                        keyboardType: TextInputType.number,
                      ).commonFild(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                AppButton(
                  w: 300.w,
                  h: 36.h,
                  title: 'Add New Card',
                  onPressed: () {
                    if (_fromKey.currentState!.validate()) {
                      Navigator.pop<CreditCard>(
                        context,
                        CreditCard(
                          cardNumber: cardNumberController.text,
                          cardHolderName: cardNumberController.text,
                          expiryDate: expiryDateController.text,
                          cvvCode: cvvController.text,
                          type: 'Master Card',
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
