import 'package:flutter/material.dart';
import 'package:wyca/imports.dart';

class CustomerService extends StatelessWidget {
  const CustomerService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.customer_service),
      ),
    );
  }
}
