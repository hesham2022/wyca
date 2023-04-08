import 'package:flutter/material.dart';

class AppForm extends StatefulWidget {
  const AppForm({
    super.key,
    required this.builder,
    this.onChanged,
    this.onWillPop,
    AutovalidateMode? autovalidateMode,
  }) : _autovalidateMode = autovalidateMode ?? AutovalidateMode.disabled;
  final Widget Function(BuildContext) builder;

  final WillPopCallback? onWillPop;

  final VoidCallback? onChanged;

  final AutovalidateMode _autovalidateMode;
  static AppFormState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppFormScope>()!._formState;
  @override
  State<AppForm> createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  final _formKey = GlobalKey<FormState>();
  bool validate() {
    return _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return AppFormScope(
      formState: this,
      child: Form(
        key: _formKey,
        autovalidateMode: widget._autovalidateMode,
        onWillPop: widget.onWillPop,
        onChanged: widget.onChanged,
        child: Builder(
          builder: widget.builder,
        ),
      ),
    );
  }
}

class AppFormScope extends InheritedWidget {
  const AppFormScope({
    super.key,
    required super.child,
    required AppFormState formState,
  }) : _formState = formState;

  final AppFormState _formState;
  AppFormState get form => _formState;

  @override
  bool updateShouldNotify(AppFormScope oldWidget) => true;
}


