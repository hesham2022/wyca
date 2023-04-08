import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';
import 'package:wyca/imports.dart';

class WashControllerPage extends StatefulWidget {
  const WashControllerPage({super.key});

  @override
  State<WashControllerPage> createState() => _WashControllerPageState();
}

class _WashControllerPageState extends State<WashControllerPage> {
  final dataController = TextEditingController();
  final timeController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(context, 'Wash Control'),
        body: Padding(
          padding: kPadding,
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is GetOrdersLoaded) {
                final washNumber = state.orders.results.fold<int>(
                  0,
                  (a, b) {
                    return a + b.washNumber;
                  },
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SectionTitile(context.l10n.currentBalance),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textAlign: TextAlign.center,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(9.5.sp),
                        hintText: '$washNumber',
                      ),
                    ).commonFild2(context),
                    const SizedBox(
                      height: 20,
                    ),
                    const SectionTitile('Washing Times'),
                    const SizedBox(
                      height: 10,
                    ),
                    AppDropDownField(
                      items: const [
                        DropDownModel(
                          name: 'Washing Times',
                        ),
                        DropDownModel(
                          name: 'Washing Times2',
                        ),
                      ],
                      onChanged: (v) {},
                      hint: 'Select Package',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppDropDownField(
                      items: [
                        ...List.generate(
                          30,
                          (index) => DropDownModel(
                            name: '${index + 1}',
                          ),
                        ),
                      ],
                      onChanged: (v) {},
                      hint: 'Washing Number',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Date',
                      style: kHead1Style.copyWith(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.date_range),
                      ),
                      controller: dataController,
                      enabled: true,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final pickedDate = await showDatePicker(
                          context: context, //context of current state
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                            2000,
                          ), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          dataController.text =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                        }
                      },
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'Time',
                      style: kHead1Style.copyWith(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.hourglass_bottom),
                      ),
                      controller: timeController,
                      enabled: true,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final time = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 0, minute: 0),
                        );
                        // time format
                        if (time != null) {
                          timeController.text = '${time.hour}:${time.minute}';
                        }
                      },
                    ),
                    SizedBox(height: 20.h),
                    AppButton(title: 'Save', onPressed: () {}),
                  ],
                );
              }
              if (state is GetOrdersFailure) {
                return Container(
                  child: Text(state.error.errorMessege),
                );
              }
              return Container(
                child: Text(state.toString()),
              );
            },
          ),
        ),
      );
}
