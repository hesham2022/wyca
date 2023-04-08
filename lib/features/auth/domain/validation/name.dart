import 'package:formz/formz.dart';

// ignore: camel_case_types
enum NameValidationError { empty, short }

class Name extends FormzInput<String, NameValidationError> {
  Name.dirty([super.value = '']) : super.dirty();
  const Name.pure() : super.pure('');
  String? errorText(NameValidationError? error) {
    // ignore: missing_enum_constant_in_switch
    switch (error) {
      case NameValidationError.empty:
        return 'first name should not be empty';

      case NameValidationError.short:
        return 'first name too short';
    }
    return null;
  }

  @override
  NameValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return NameValidationError.empty;
    } else if (value.length < 4) {
      return NameValidationError.short;
    }
    return null;
  }
}

// ignore: camel_case_types

class LastName extends FormzInput<String, NameValidationError> {
  LastName.dirty([super.value = '']) : super.dirty();
  const LastName.pure() : super.pure('');
  String? errorText(NameValidationError? error) {
    // ignore: missing_enum_constant_in_switch
    switch (error) {
      case NameValidationError.empty:
        return 'last name should not be empty';

      case NameValidationError.short:
        return 'last name too short';
    }
    return null;
  }

  @override
  NameValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return NameValidationError.empty;
    } else if (value.length < 2) {
      return NameValidationError.short;
    }
    return null;
  }
}
