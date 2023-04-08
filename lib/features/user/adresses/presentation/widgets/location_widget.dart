import 'package:flutter/material.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/user/adresses/presentation/pages/location_page.dart';
import 'package:wyca/imports.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
    required this.controller,
    required this.address,
  });
  final TextEditingController controller;
  final Address address;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enabled: false,
      readOnly: true,
      style: kHead1Style.copyWith(fontSize: 14.sp, color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(9.sp),
        suffixIcon: IconButton(
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute(
                builder: (_) => LocationPage(address: address),
              ),
            );
          },
          icon: const Icon(Icons.location_pin),
        ),
        enabledBorder: kOutlinePrimaryColor,
        disabledBorder: kOutlinePrimaryColor,
        focusedBorder: kOutlinePrimaryColor,
        errorBorder: kOutlinePrimaryColor,
      ),
    );
  }
}
