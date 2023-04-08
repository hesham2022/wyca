import 'package:flutter/material.dart';

class NewForm extends Form {
  const NewForm({
    super.key,
    required super.child,
    super.onWillPop,
    super.onChanged,
    super.autovalidateMode,
  });
  @override
  NewFormState createState() {
    return NewFormState();
  }
}

class NewFormState extends FormState {
  int _generation = 0;
  final bool _hasInteractedByUser = false;
  final Set<FormFieldState<dynamic>> _fields = <FormFieldState<dynamic>>{};

  void _forceRebuild() {
    setState(() {
      ++_generation;
    });
  }

  void _register(FormFieldState<dynamic> field) {
    _fields.add(field);
  }

  void _unregister(FormFieldState<dynamic> field) {
    _fields.remove(field);
  }
}
