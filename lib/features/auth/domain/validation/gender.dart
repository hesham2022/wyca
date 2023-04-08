import 'package:formz/formz.dart';

// ignore: camel_case_types
enum GenderValidationError { empty, short }

class Gender extends FormzInput<String, GenderValidationError> {
  Gender.dirty([super.value = '']) : super.dirty();
  const Gender.pure() : super.pure('');
  @override
  GenderValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return GenderValidationError.empty;
    } else if (value.length < 4) {
      return GenderValidationError.short;
    }
    return null;
  }
}
