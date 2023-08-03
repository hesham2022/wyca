import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/features/user/order/presentation/bloc/order_bloc.dart';
import 'package:wyca/features/user/order/presentation/pages/chosse_adresse_page.dart';
import 'package:wyca/imports.dart';

class OrderLaterScreen extends StatefulWidget {
  const OrderLaterScreen({super.key});

  @override
  State<OrderLaterScreen> createState() => _OrderLaterScreenState();
}

class _OrderLaterScreenState extends State<OrderLaterScreen> {
  final dataController = TextEditingController();
  final timeController = TextEditingController();
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, context.l10n.chooseTheDate),
      body: Padding(
        padding: kPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child:
                    Lottie.asset('assets/lottie/appointment.json', width: 150)),
            Text(
              context.l10n.date,
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
                  firstDate: DateTime
                      .now(), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  date = pickedDate;
                  dataController.text =
                      DateFormat('dd-MM-yyyy').format(pickedDate);
                }
              },
            ),
            SizedBox(height: 15.h),
            Text(
              context.l10n.time,
              style: kHead1Style.copyWith(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            TextFormField(
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.date_range),
              ),
              controller: timeController,
              enabled: true,
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                final time = await showTimePicker(
                  context: context,
                  builder: (context, child) => TimePickerDialog(
                    initialTime: TimeOfDay(
                      hour: DateTime.now().hour,
                      minute: DateTime.now().minute,
                    ),
                  ),
                  initialTime: TimeOfDay(
                    hour: DateTime.now().hour,
                    minute: DateTime.now().minute,
                  ),
                );
                // time format
                if (time != null) {
                  final difference = DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    time.hour,
                    time.minute,
                  ).difference(
                    DateTime.now(),
                  );
                  if (difference.inMinutes > 1) {
                    date = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                    timeController.text = '${time.hour}:${time.minute}';
                  } else {
                    await Fluttertoast.showToast(
                      msg: context.l10n.timeShouldBeAfterNow,
                    );
                  }
                }
              },
            ),
            SizedBox(height: 15.h),
            AppButton(
              h: 36.h,
              title: context.l10n.next,
              onPressed: () {
                if (timeController.text.isNotEmpty &&
                    dataController.text.isNotEmpty) {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChosseAdressePage(
                        packageId: context.read<OrderBloc>().idControoler.text,
                        date: date,
                      ),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: context.l10n.pleaseProvideDaeAndTime,
                  );
                }
                //ChosseAdressePage
              },
            )
          ],
        ),
      ),
    );
  }
}
