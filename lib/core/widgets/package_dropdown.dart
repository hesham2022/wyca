import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/features/user/home/domain/entities/package.dart';
import 'package:wyca/features/user/order/presentation/pages/isPackage_exist.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/gen/colors.gen.dart';

class PackageDropDownField extends StatefulWidget {
  const PackageDropDownField({
    super.key,
    required this.items,
    this.validator,
    // required this.value,
    required this.onChanged,
    this.package,
    this.title,
    this.selectedStyle,
    this.initialValue,
    required this.hint,
  });
  final Package? package;

  final List<Package> items;
  // final DropDownModel? value;
  final String? Function(Package?)? validator;
  final void Function(Package?)? onChanged;
  final String? title;
  final String hint;
  final TextStyle? selectedStyle;
  final Package? initialValue;

  @override
  State<PackageDropDownField> createState() => _PackageDropDownFieldState();
}

class _PackageDropDownFieldState extends State<PackageDropDownField> {
  Package? initialValue;
  @override
  void initState() {
    setState(() {
      initialValue = widget.initialValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.items.where((e) => e.washNumber > 0).map((e) => e.washNumber));
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
        DropdownButtonFormField<Package>(
          icon: Assets.svg.arrowDown3101.svg(
            color: ColorName.primaryColor,
            height: 12.h,
            width: 12.w,
          ),
          value: initialValue,
          elevation: 0,
          isExpanded: true,
          selectedItemBuilder: (context) => widget.items
              .where((element) => element.washNumber > 0)
              .map(
                (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      initialValue?.name ?? 'Select User Type',
                      style: widget.selectedStyle ??
                          kHead1Style.copyWith(fontSize: 12.sp),
                    ),
                    if (isPackageExist(
                      context,
                      initialValue == null ? '' : initialValue!.id,
                    ))
                      restOfWash(context, initialValue!.id) == 0
                          ? Text(
                              '${initialValue?.price} LE  ' ?? '',
                              style: widget.selectedStyle ??
                                  kHead1Style.copyWith(fontSize: 12.sp),
                            )
                          : Text(
                              '${restOfWash(context, initialValue!.id)} Wash ',
                              style: widget.selectedStyle ??
                                  kHead1Style.copyWith(fontSize: 12.sp),
                            )
                    else
                      Text(
                        '${initialValue?.price} LE  ' ?? '',
                        style: widget.selectedStyle ??
                            kHead1Style.copyWith(fontSize: 12.sp),
                      ),
                  ],
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
            return DropdownMenuItem<Package>(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value.name,
                      style: kHead1Style.copyWith(fontSize: 12.sp),
                    ),
                    if (isPackageExist(context, value.id))
                      restOfWash(context, value.id) == 0
                          ? Text(
                              '${value.price} LE  ',
                              style: widget.selectedStyle ??
                                  kHead1Style.copyWith(fontSize: 12.sp),
                            )
                          : Text(
                              '${restOfWash(context, value.id)} Wash ',
                              style: widget.selectedStyle ??
                                  kHead1Style.copyWith(fontSize: 12.sp),
                            )
                    else
                      Text(
                        '${value.price} LE',
                        style: kHead1Style.copyWith(fontSize: 12.sp),
                      )
                  ],
                ),
              ),
            );
          }).toList(),
          decoration: InputDecoration(
            errorBorder: kOutlinePrimaryColor,
            focusedErrorBorder: kOutlinePrimaryColor,
            enabledBorder: kOutlinePrimaryColor,
            focusedBorder: kOutlinePrimaryColor,
            border: kOutlinePrimaryColor,
            hintText: widget.hint,
          ),
        ),
      ],
    );
  }
}
