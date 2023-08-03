import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/gen/colors.gen.dart';

class AppDropDownField extends StatefulWidget {
  const AppDropDownField({
    super.key,
    required this.items,
    this.validator,
    // required this.value,
    required this.onChanged,
    this.title,
    this.selectedStyle,
    this.initialValue,
    required this.hint,
  });
  final List<DropDownModel> items;
  // final DropDownModel? value;
  final String? Function(DropDownModel?)? validator;
  final void Function(DropDownModel?)? onChanged;
  final String? title;
  final String hint;
  final TextStyle? selectedStyle;
  final DropDownModel? initialValue;

  @override
  State<AppDropDownField> createState() => _AppDropDownFieldState();
}

class _AppDropDownFieldState extends State<AppDropDownField> {
  DropDownModel? initialValue;
  @override
  void initState() {
    setState(() {
      initialValue = widget.initialValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            widget.title ?? '',
            style: kHead1Style.copyWith(
              fontSize: 12.sp,
              color: const Color(0xff434343),
            ),
          ),
        if (widget.title != null)
          SizedBox(
            height: 4.h,
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<DropDownModel>(
            icon: Assets.svg.arrowDown3101.svg(
              color: ColorName.primaryColor,
              height: 12.h,
              width: 12.w,
            ),
            value: initialValue,
            elevation: 0,
            isExpanded: true,
            selectedItemBuilder: (context) => widget.items
                .map(
                  (e) => Text(
                    initialValue?.name ?? 'Select User Type',
                    style: widget.selectedStyle ??
                        kHead1Style.copyWith(fontSize: 12.sp),
                  ),
                )
                .toList(),
            dropdownColor: Colors.transparent,
            onChanged: (value) {
              setState(() {
                initialValue = value;
              });
              widget.onChanged?.call(value);
            },
            validator: widget.validator,
            items: widget.items.map((value) {
              return DropdownMenuItem<DropDownModel>(
                //   alignment: AlignmentDirectional.topStart,
                value: value,
                child: Container(
                  height: 53.h,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Text(
                    value.name,
                    style: kHead1Style.copyWith(fontSize: 12.sp),
                  ),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              errorBorder: kOutlinePrimaryColor,
              focusedErrorBorder: kOutlinePrimaryColor,
              enabledBorder: kOutlinePrimaryColor,
              focusedBorder: kOutlinePrimaryColor,
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: widget.hint,
            ),
          ),
        ),
      ],
    );
  }
}

class DropDownModel extends Equatable {
  const DropDownModel({required this.name, this.name2});

  final String name;
  final String? name2;
  @override
  List<Object?> get props => [name];
}

class DropDownModelwithId extends DropDownModel {
  const DropDownModelwithId({required super.name, required this.id});

  final String id;
  @override
  List<Object?> get props => [id];
}
