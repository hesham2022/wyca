import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/core/widgets/app_checkbox.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:wyca/features/auth/presentation/pages/provider/sign_up_second.dart';
import 'package:wyca/features/auth/presentation/widgets/login_bar.dart';
import 'package:wyca/features/auth/presentation/widgets/password_field.dart';
import 'package:wyca/imports.dart';

class ProviderSignUpPage extends StatefulWidget {
  const ProviderSignUpPage({super.key});

  @override
  State<ProviderSignUpPage> createState() => _ProviderSignUpPageState();
}

class _ProviderSignUpPageState extends State<ProviderSignUpPage> {
  final _firstNamefocusNode = FocusNode();
  final _lastNamefocusNode = FocusNode();
  final _emailfocusNode = FocusNode();
  final _passwordfocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  late RegisterProviderBloc _bloc;
  late LoginState _state;
  @override
  void initState() {
    _bloc = getIt();
    _state = _bloc.state;
    _bloc.stream.listen((state) {
      _state = state;
    });

    _firstNamefocusNode.addListener(
      () {
        if (!_firstNamefocusNode.hasFocus) {
          if (_state.name.invalid == true || _state.name.pure) {
            Fluttertoast.cancel().then((value) {
              Fluttertoast.showToast(
                msg: _state.name.errorText(_state.name.error) ??
                    'somthing go wrong',
              );
            });
          }
        }
      },
    );
    _lastNamefocusNode.addListener(
      () {
        if (!_lastNamefocusNode.hasFocus) {
          if (_state.lastName.invalid == true || _state.lastName.pure) {
            Fluttertoast.cancel().then((value) {
              Fluttertoast.showToast(
                msg: _state.lastName.errorText(_state.lastName.error) ??
                    context.l10n.someThingGoPassword,
              );
            });
          }
        }
      },
    );
    _emailfocusNode.addListener(
      () {
        if (!_emailfocusNode.hasFocus) {
          if (_state.username.invalid == true || _state.username.pure) {
            Fluttertoast.cancel().then((value) {
              Fluttertoast.showToast(
                msg: _state.username.errorText(_state.username.error) ??
                    context.l10n.someThingGoPassword,
              );
            });
          }
        }
      },
    );
    _phoneNumberFocusNode.addListener(
      () {
        if (!_phoneNumberFocusNode.hasFocus) {
          if (_state.phoneNumber.invalid == true || _state.phoneNumber.pure) {
            Fluttertoast.cancel().then((value) {
              Fluttertoast.showToast(
                msg: _state.phoneNumber.errorText(_state.phoneNumber.error) ??
                    context.l10n.someThingGoPassword,
              );
            });
          }
        }
      },
    );
    _passwordfocusNode.addListener(
      () {
        if (!_passwordfocusNode.hasFocus) {
          if (_state.password.invalid == true || _state.password.pure) {
            Fluttertoast.cancel().then((value) {
              Fluttertoast.showToast(
                msg: _state.password.errorText(_state.password.error) ??
                    context.l10n.someThingGoPassword,
              );
            });
          }
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterProviderBloc>.value(
          value: _bloc,
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: kPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40.h),
                LogoBar(
                  title: context.l10n.createANewAccount,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<RegisterProviderBloc, LoginState>(
                        buildWhen: (previous, current) =>
                            previous.name != current.name,
                        builder: (context, state) {
                          return TextFormField(
                            focusNode: _firstNamefocusNode,
                            decoration: InputDecoration(
                              hintText: context.l10n.firstName,
                            ),
                            onChanged: (value) => context
                                .read<RegisterProviderBloc>()
                                .add(LoginNameChanged(value)),
                          ).commonFild(context);
                        },
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: BlocBuilder<RegisterProviderBloc, LoginState>(
                        buildWhen: (previous, current) =>
                            previous.lastName != current.lastName,
                        builder: (context, state) {
                          return TextFormField(
                            focusNode: _lastNamefocusNode,
                            decoration: InputDecoration(
                              hintText: context.l10n.lastName,
                            ),
                            onChanged: (value) => context
                                .read<RegisterProviderBloc>()
                                .add(LoginLastNameChanged(value)),
                          ).commonFild(context);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                BlocBuilder<RegisterProviderBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      previous.username != current.username,
                  builder: (context, state) {
                    return TextFormField(
                      focusNode: _emailfocusNode,
                      decoration: InputDecoration(
                        hintText: context.l10n.email,
                      ),
                      onChanged: (value) => context
                          .read<RegisterProviderBloc>()
                          .add(LoginUsernameChanged(value)),
                    ).commonFild(context);
                  },
                ),
                SizedBox(height: 10.h),
                BlocBuilder<RegisterProviderBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      previous.phoneNumber != current.phoneNumber,
                  builder: (context, state) {
                    return TextFormField(
                      focusNode: _phoneNumberFocusNode,
                      decoration:  InputDecoration(
                        prefixText: '+2',
                        hintText: context.l10n.mobileNumber,
                      ),
                      onChanged: (value) => context
                          .read<RegisterProviderBloc>()
                          .add(LoginPhoneNumberChanged(value)),
                    ).commonFild(context);
                  },
                ),
                SizedBox(height: 10.h),
                Builder(
                  builder: (context) {
                    return AppDropDownField(
                      items: const [
                        DropDownModel(name: 'Male'),
                        DropDownModel(name: 'Female')
                      ],
                      onChanged: (value) => context
                          .read<RegisterProviderBloc>()
                          .add(LoginGenderhanged(value!.name)),
                      selectedStyle: kBody1Style.copyWith(
                        fontSize: 14.sp,
                        color: const Color(0xff363636),
                      ),
                      hint: context.l10n.gender,
                    ).build(context);
                  },
                ),
                SizedBox(height: 10.h),
                PasswordRegisterProviderField(
                  focusNode: _passwordfocusNode,
                ),
                SizedBox(height: 10.h),
                // const PasswordField.confrimPassword(
                //   key: Key('confirm_password_field'),
                // ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    AppCheckBox(
                      onChanged: (value) {},
                      initialValue: false,
                    ),
                    Text(
                      context.l10n.agreeToConditions,
                      style: kBody1Style.copyWith(
                        fontSize: 12.sp,
                        color: ColorName.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                BlocBuilder<RegisterProviderBloc, LoginState>(
                  // buildWhen: (previous, current) =>
                  //     previous.status != current.status,

                  builder: (contextA, state) {
                    return AppButton(
                      w: 119.w,
                      title: context.l10n.next,
                      onPressed: (state.password.error == null &&
                              state.name.error == null &&
                              state.gender.error == null &&
                              state.phoneNumber.error == null &&
                              state.username.error == null)
                          ? () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value:
                                        contextA.read<RegisterProviderBloc>(),
                                    child: const SignUpSecond(),
                                  ),
                                ),
                              );
                              //  widget.onPressed();
                            }
                          : null,
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: context.l10n.haveAccount,
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                          text: context.l10n.login,
                          style: kBody1Style.copyWith(
                            fontSize: 16.sp,
                            color: ColorName.primaryColor,
                          ),
                        ),
                      ],
                      style: kBody1Style,
                    ),
                  ),
                ),
                SizedBox(height: 36.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
