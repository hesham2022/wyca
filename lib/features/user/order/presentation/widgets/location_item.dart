import 'package:flutter/material.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/imports.dart';

class LocationItem extends StatefulWidget {
  const LocationItem({
    super.key,
    required this.adresses,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    this.description,
  });

  final String adresses;
  final String? description;

  final Address value;
  final Address groupValue;
  final void Function(Address?)? onChanged;

  @override
  State<LocationItem> createState() => _LocationItemState();
}

class _LocationItemState extends State<LocationItem> {
  @override
  Widget build(BuildContext context) => RadioListTile<Address>(
        activeColor: Colors.black,
        title: Text(widget.description ?? widget.adresses),
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: (v) {
          if (widget.onChanged != null) {
            widget.onChanged!.call(v);
          }
          setState(() {});
        },
      );
}

class AppRadioListTile extends StatelessWidget {
  const AppRadioListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.groupValue,
    this.titleWidget,
    required this.leadingIcon,
  });

  final String title;
  final Widget? titleWidget;

  final String value;
  final String groupValue;
  final Widget leadingIcon;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leadingIcon,
              SizedBox(width: 16.w),
              titleWidget ??
                  Expanded(
                    child: Text(
                      title,
                      style: kHead1Style.copyWith(
                        fontSize: 14.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
              const Spacer(),
              Radio<String>(
                fillColor:
                    MaterialStateProperty.all<Color>(ColorName.primaryColor),
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
              )
            ],
          ),
          SizedBox(height: 10.h),
        ],
      );
}
