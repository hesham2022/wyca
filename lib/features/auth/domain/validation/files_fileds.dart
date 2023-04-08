import 'package:formz/formz.dart';

// ignore: camel_case_types
enum NameValidationError { empty, short }

class CriminalFish extends FormzInput<String, NameValidationError> {
  CriminalFish.dirty([super.value = '']) : super.dirty();
  const CriminalFish.pure() : super.pure('');
  String? errorText(NameValidationError? error) {
    // ignore: missing_enum_constant_in_switch
    switch (error) {
      case NameValidationError.empty:
        return 'Criminal Fish name should not be empty';

      case NameValidationError.short:
        return 'Criminal Fish name too short';
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

class BackId extends FormzInput<String, NameValidationError> {
  BackId.dirty([super.value = '']) : super.dirty();
  const BackId.pure() : super.pure('');
  String? errorText(NameValidationError? error) {
    // ignore: missing_enum_constant_in_switch
    switch (error) {
      case NameValidationError.empty:
        return 'Back Id name should not be empty';

      case NameValidationError.short:
        return 'Back Id name too short';
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

class FrontId extends FormzInput<String, NameValidationError> {
  FrontId.dirty([super.value = '']) : super.dirty();
  const FrontId.pure() : super.pure('');
  String? errorText(NameValidationError? error) {
    // ignore: missing_enum_constant_in_switch
    switch (error) {
      case NameValidationError.empty:
        return 'Front Id name should not be empty';

      case NameValidationError.short:
        return 'Front Id name too short';
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

class Photo extends FormzInput<String, NameValidationError> {
  Photo.dirty([super.value = '']) : super.dirty();
  const Photo.pure() : super.pure('');
  String? errorText(NameValidationError? error) {
    // ignore: missing_enum_constant_in_switch
    switch (error) {
      case NameValidationError.empty:
        return 'photo name should not be empty';

      case NameValidationError.short:
        return 'photo name too short';
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
