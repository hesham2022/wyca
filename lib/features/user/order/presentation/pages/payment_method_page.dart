import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/request/domain/params/craeet_request.dart';
import 'package:wyca/features/request/presentation/request_cubit.dart';
import 'package:wyca/features/user/home/presentation/packages_bloc/packages_bloc.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';
import 'package:wyca/features/user/order/presentation/pages/add_newcard.dart';
import 'package:wyca/features/user/order/presentation/widgets/location_item.dart';
import 'package:wyca/global_data.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/web_view.dart';

enum PaymentWay {
  cash,
  credit,
  paypal,
}

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key, this.address, required this.packageId});
  final Address? address;
  final String packageId;
  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String _currentPaymentWay = PaymentWay.credit.toString();
  Widget _paymentMethodWidget() {
    return Column(
      children: [
        // AppRadioListTile(
        //   title: context.l10n.cash,
        //   value: PaymentWay.cash.toString(),
        //   onChanged: (value) {
        //     setState(() {
        //       _currentPaymentWay = value!;
        //     });
        //   },
        //   groupValue: _currentPaymentWay,
        //   leadingIcon: Assets.svg.walletSvgrepoCom.svg(
        //     color: ColorName.primaryColor,
        //     height: 20.h,
        //     width: 20.w,
        //   ),
        // ),
        AppRadioListTile(
          title: context.l10n.creditCard,
          value: PaymentWay.credit.toString(),
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
      ],
    );
  }

  String currentCard = kCrdeitCards.last.cardNumber;
  Widget _crdeitCardsWidget() {
    return Column(
      children: [
        ...kCrdeitCards
            .map(
              (e) => AppRadioListTile(
                title: e.type,
                titleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${e.type}-${last4Digits(e.cardNumber)}',
                      maxLines: 1,
                      style: kHead1Style.copyWith(
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      e.expiryDate,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                value: e.cardNumber,
                onChanged: (value) {
                  setState(() {
                    currentCard = value!;
                  });
                },
                groupValue: currentCard,
                leadingIcon: Assets.svg.icons8MastercardLogo.svg(
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            )
            .toList(),
        AppRadioListTile(
          title: context.l10n.addnewcard,
          value: '',
          onChanged: (value) async {
            final creditCard = await Navigator.push<CreditCard>(
              context,
              MaterialPageRoute(builder: (_) => const AddNewPaymentCrd()),
            );
            if (creditCard != null) {
              setState(() {
                kCrdeitCards.add(creditCard);
                currentCard = creditCard.cardNumber;
              });
            }
          },
          groupValue: currentCard,
          leadingIcon: const Icon(Icons.payment),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final package =
        (context.read<PackagesCubit>().state as PackagesCubitStateLoaded)
            .packages
            .firstWhere(
              (element) => element.id == widget.packageId,
            );
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.paymentMethods)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SectionTitile(
              context.l10n.addCoupon,
              color: Colors.black,
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintStyle: kBody1Style.copyWith(
                  fontSize: 12.sp,
                  color: const Color(0xff363636),
                ),
                hintText: context.l10n.addYourCoupon,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(13.sp),
                  child: RichText(
                    text: TextSpan(
                      text: context.l10n.submit,
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      style: kHead1Style.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ),
                enabledBorder: kOutlinePrimaryColor,
                disabledBorder: kOutlinePrimaryColor,
                focusedBorder: kOutlinePrimaryColor,
                errorBorder: kOutlinePrimaryColor,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            SectionTitile(
              context.l10n.paymentMethods,
              color: Colors.black,
            ),
            SizedBox(
              height: 12.5.h,
            ),
            _paymentMethodWidget(),
            // AnimatedSwitcher(
            //   duration: const Duration(milliseconds: 300),
            //   child: _currentPaymentWay == PaymentWay.creditCard.toString()
            //       ? _crdeitCardsWidget()
            //       : _paymentMethodWidget(),
            // ),
            SizedBox(
              height: 25.h,
            ),
            SectionTitile(
              context.l10n.orderSummary,
              color: Colors.black,
            ),
            SizedBox(
              height: 12.5.h,
            ),
            TotoalWisget(
              title: context.l10n.amount,
              price: '${package.price} ${context.l10n.le}',
            ),
            SizedBox(
              height: 10.h,
            ),
            if (package.priceDiscount > 0)
              TotoalWisget(
                title: context.l10n.discount,
                price: '${package.priceDiscount} ${context.l10n.le}',
              ),
            SizedBox(
              height: 10.h,
            ),
            const MySeparator(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10.h,
            ),
            TotoalWisget.total(
              title: context.l10n.totalAmount,
              price:
                  '${package.price - package.priceDiscount} ${context.l10n.le}',
            ),
            SizedBox(
              height: 25.h,
            ),
            BlocListener<RequestCubit, RequestCubitState>(
              listener: (context, state) {
                if (state is RequestCubitStateSent) {
                  context.router.pushAndPopUntil(
                    CompleteRequestRoute(requestClass: state.request),
                    predicate: (r) => false,
                  );
                }
              },
              child: BlocListener<OrderBloc, OrderState>(
                listener: (context, state) {
                  if (state is CreateOrderSuccessState) {
                    context.read<RequestCubit>().createRequest(
                          CreateRequestParams(
                            address: widget.address!,
                            order: state.order.id,
                          ),
                        );
                  }
                  if (state is CreateOrderSuccessStateWithPayLink) {
                    print(state.order.paymentLink);
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WebViewPaymentPage(
                          callbackPayment: (url) {
                            if (url.contains('&success=true&')) {
                              context.read<RequestCubit>().createRequest(
                                    CreateRequestParams(
                                      address: widget.address!,
                                      order: state.order.id,
                                    ),
                                  );
                              // context.router.push(const DoneRoute());
                            } else {}
                          },
                          url: state.order.paymentLink!,
                          title: 'payment',
                        ),
                      ),
                    );
                  }
                },
                child: BlocBuilder<OrderBloc, OrderState>(
                  //GetOrdersLoading
                  builder: (context, state) {
                    if (state is GetOrdersLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AppButton(
                      title: context.l10n.serviceRequest,
                      onPressed: () {
                        // Fluttertoast.showToast(msg: widget.packageId);
                        context.read<OrderBloc>().add(
                              CreateOrder(
                                widget.packageId,
                                _currentPaymentWay.split('.').last,
                              ),
                            ); // showAboutDialog(
                      },
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TotoalWisget extends StatelessWidget {
  TotoalWisget({
    super.key,
    required this.title,
    required this.price,
  });
  TotoalWisget.total({
    super.key,
    required this.title,
    required this.price,
  }) : style = kHead1Style.copyWith(
          fontSize: 14.sp,
          color: Colors.black,
        );
  final String title;
  final String price;
  // kHead1Style.copyWith(
  //   fontSize: 14.sp,
  //   color: Colors.black,
  // )
  TextStyle style = kBody1Style.copyWith(
    fontSize: 14.sp,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: style,
        ),
        Text(
          price,
          style: style.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
