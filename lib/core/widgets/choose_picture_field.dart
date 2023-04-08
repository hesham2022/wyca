import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';

class ChoosePictureField extends StatefulWidget {
  ChoosePictureField({
    super.key,
    required this.onTap,
    this.validator,
    this.controller,
  });
  final VoidCallback onTap;
  final TextEditingController? controller;
  String? Function(String?)? validator;

  @override
  State<ChoosePictureField> createState() => _ChoosePictureFieldState();
}

class _ChoosePictureFieldState extends State<ChoosePictureField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        widget.onTap();
      },
      decoration: InputDecoration(
        hintText: context.l10n.noPhotoSelectedYet,
        hintStyle: kHead1Style.copyWith(color: Colors.black, fontSize: 11.sp),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorName.primaryColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              context.l10n.choosePhoto,
              style: kHead1Style.copyWith(
                color: Colors.black,
                fontSize: 10.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
