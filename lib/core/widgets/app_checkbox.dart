import 'package:flutter/material.dart';
import 'package:wyca/gen/colors.gen.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });
  final bool initialValue;
  final Function(bool? value) onChanged;
  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  late bool _value;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      fillColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return ColorName.primaryColor;
        }
        return ColorName.primaryColor.withOpacity(0.5);
      }),
      activeColor: Colors.black,
      value: _value,
      onChanged: (value) {
        widget.onChanged(value);
        setState(() {
          _value = !_value;
        });
      },
    );
  }
}
