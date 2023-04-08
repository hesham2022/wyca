part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Email.pure(),
    this.password = const Password.pure(),
    this.name = const Name.pure(),
    this.gender = const Gender.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.lastName = const LastName.pure(),
    this.backId = const BackId.pure(),
    this.photo = const Photo.pure(),
    this.frontId = const FrontId.pure(),
    this.emailOrPhone = const EmailOrPhone.pure(),
    this.criminalFish = const CriminalFish.pure(),
    this.failureMessege = '',
    this.address = '',
    this.coordinates = const [31.0, 30],
  });
  final String address;
  final List<double> coordinates;
  final FormzStatus status;
  final Email username;
  final Password password;
  final Name name;
  final LastName lastName;
  final PhoneNumber phoneNumber;
  final Gender gender;
  final CriminalFish criminalFish;
  final Photo photo;
  final BackId backId;
  final FrontId frontId;
  final EmailOrPhone emailOrPhone;

  final String failureMessege;

  LoginState copyWith({
    FormzStatus? status,
    Email? username,
    Password? password,
    Name? name,
    Gender? gender,
    LastName? lastName,
    PhoneNumber? phoneNumber,
    Photo? photo,
    BackId? backId,
    EmailOrPhone? emailOrPhone,
    FrontId? frontId,
    CriminalFish? criminalFish,
    String? failureMessege,
    String? address,
    List<double>? coordinates,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      backId: backId ?? this.backId,
      frontId: frontId ?? this.frontId,
      emailOrPhone: emailOrPhone ?? this.emailOrPhone,
      photo: photo ?? this.photo,
      criminalFish: criminalFish ?? this.criminalFish,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      failureMessege: failureMessege ?? this.failureMessege,
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        password,
        lastName,
        name,
        phoneNumber,
        gender,
        failureMessege,
        photo,
        criminalFish,
        backId,
        frontId,
        address,
        coordinates,
        emailOrPhone
      ];
}
