import 'package:dartz/dartz.dart';
import 'package:formz/formz.dart';
import 'package:wyca/core/utils/validation_regx.dart';

enum EmailValidationError { empty, inValid, invalidPhoneNumber }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String? value) {
    return emailValidator(value!).fold((l) => l, (r) => null);
  }

  String? errorText(EmailValidationError? error) {
    // ignore: missing_enum_constant_in_switch
    switch (error) {
      case EmailValidationError.empty:
        return 'Email should not be empty';

      case EmailValidationError.inValid:
        return 'inValid email';
    }
    return null;
  }
}

Either<EmailValidationError, void> emailValidator(String value) {
  if (value.isEmpty) {
    return const Left(EmailValidationError.empty);
  } else if (!ValidationsPatterns.emailValidate.hasMatch(value)) {
    return const Left(EmailValidationError.inValid);
  }
  return const Right(null);
}

class EmailOrPhone extends FormzInput<String, EmailValidationError> {
  const EmailOrPhone.pure() : super.pure('');
  const EmailOrPhone.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String? value) {
    return emailOrPhoneValidator(value!).fold((l) => l, (r) => null);
  }

  bool get isEmail => value.contains('@');
  String? errorText(EmailValidationError? error) {
    // ignore: missing_enum_constant_in_switch
    switch (error) {
      case EmailValidationError.empty:
        return 'email should not be empty';

      case EmailValidationError.invalidPhoneNumber:
        return 'inValid phone number or email';
    }
    return null;
  }
}

Either<EmailValidationError, void> emailOrPhoneValidator(String value) {
  const patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  final phoneRegx = RegExp(patttern);

  if (value.isEmpty) {
    return const Left(EmailValidationError.empty);
  }
  if (value.contains('@')) {
    if (!ValidationsPatterns.emailValidate.hasMatch(value)) {
      return const Left(EmailValidationError.inValid);
    }
  }
  if (!phoneRegx.hasMatch(value)) {
    return const Left(EmailValidationError.invalidPhoneNumber);
  }
  //  else if (!ValidationsPatterns.emailValidate.hasMatch(value) &&
  //     !phoneRegx.hasMatch(value)) {
  //   return const Left(EmailValidationError.inValid);
  // }
  return const Right(null);
}
