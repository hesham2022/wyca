import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/app_checkbox.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:wyca/features/auth/presentation/widgets/login_bar.dart';
import 'package:wyca/features/auth/presentation/widgets/password_field.dart';
import 'package:wyca/gen/colors.gen.dart';
import 'package:wyca/l10n/l10n.dart';

class SignFormBuilder extends StatefulWidget {
  const SignFormBuilder({
    super.key,
    required this.topPosition,
    required this.onPressed,
  });
  final double Function(int index) topPosition;
  final VoidCallback onPressed;
  @override
  State<SignFormBuilder> createState() => _SignFormBuilderState();
}

class _SignFormBuilderState extends State<SignFormBuilder> {
  final _firstNamefocusNode = FocusNode();
  final _lastNamefocusNode = FocusNode();
  final _emailfocusNode = FocusNode();
  final _passwordfocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  late RegisterBloc _bloc;
  late LoginState _state;
  @override
  void initState() {
    _bloc = context.read<RegisterBloc>();
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

    setState(() {
      Future.delayed(
        const Duration(milliseconds: 1),
        () {
          setState(() {
            begin = true;
          });
        },
      );
    });
    super.initState();
  }

  bool begin = false;
  bool end = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedPositioned(
          onEnd: () {
            setState(() {
              end = true;
            });
          },
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          left: 0,
          right: 0,
          top: !begin ? 60.h : 30.h,
          child: LogoBar(
            title: context.l10n.createANewAccount,
          ),
        ),
        BlocBuilder<RegisterBloc, LoginState>(
          buildWhen: (previous, current) =>
              previous.username != current.username,
          builder: (context, state) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              left: 0,
              right: 0,
              //  top: widget.topPosition(begin ? 1 : 0),
              top: widget.topPosition(1),

              child: AnimatedOpacity(
                opacity: begin ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: TextFormField(
                  focusNode: _emailfocusNode,
                  decoration: InputDecoration(
                    hintText: context.l10n.email,
                  ),
                  onChanged: (username) => context
                      .read<RegisterBloc>()
                      .add(LoginUsernameChanged(username)),
                ).commonFild(context),
              ),
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          top: widget.topPosition(0),
          child: AnimatedOpacity(
            opacity: !begin ? 0 : 1,
            duration: const Duration(milliseconds: 250),
            child: Row(
              children: [
                Expanded(
                  child: BlocBuilder<RegisterBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.name != current.name,
                    builder: (context, state) {
                      return TextFormField(
                        focusNode: _firstNamefocusNode,
                        decoration: InputDecoration(
                          hintText: context.l10n.firstName,
                        ),
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .add(LoginNameChanged(value)),
                      ).commonFild(context);
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<RegisterBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.lastName != current.lastName,
                    builder: (context, state) {
                      return TextFormField(
                        decoration: InputDecoration(
                          hintText: context.l10n.lastName,
                        ),
                        focusNode: _lastNamefocusNode,
                        onChanged: (value) => context
                            .read<RegisterBloc>()
                            .add(LoginLastNameChanged(value)),
                      ).commonFild(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        if (!begin)
          AnimatedPositioned(
            key: const Key('emial_or_phone'),
            duration: const Duration(milliseconds: 250),
            left: 0,
            right: 0,
            top: widget.topPosition(!begin ? 1 : 0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: context.l10n.emailOrPhoneNumber,
              ),
            ).commonFild(context),
          ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          left: 0,
          right: 0,
          //top: widget.topPosition(begin ? 2 : 0),
          top: widget.topPosition(2),

          child: BlocBuilder<RegisterBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.phoneNumber != current.phoneNumber,
            builder: (context, state) {
              return AnimatedOpacity(
                opacity: begin ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: TextFormField(
                  focusNode: _phoneNumberFocusNode,
                  onChanged: (value) => context
                      .read<RegisterBloc>()
                      .add(LoginPhoneNumberChanged(value)),
                  decoration: InputDecoration(
                    prefixText: '+2',
                    hintText: context.l10n.mobileNumber,
                  ),
                ).commonFild(context),
              );
            },
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          left: 0,
          right: 0,
          top: widget.topPosition(3),
          child: AnimatedOpacity(
            opacity: begin ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: AppDropDownField(
              items: const [
                DropDownModel(name: 'male'),
                DropDownModel(name: 'female')
              ],
              onChanged: (value) {
                context
                    .read<RegisterBloc>()
                    .add(LoginGenderhanged(value!.name));
              },
              selectedStyle: kBody1Style.copyWith(
                fontSize: 14.sp,
                color: const Color(0xff363636),
              ),
              hint: context.l10n.gender,
            ).build(context),
            //  TextFormField(
            //   decoration: const InputDecoration(
            //     hintText: 'Gender',
            //   ),
            // ).build(context),
          ),
        ),
        AnimatedPositioned(
          key: const Key('password'),
          duration: const Duration(milliseconds: 250),
          left: 0,
          right: 0,
          top: widget.topPosition(begin ? 4 : 2),
          child: PasswordRegisterField(
            focusNode: _passwordfocusNode,
          ),
        ),
        // AnimatedPositioned(
        //   onEnd: () {},
        //   key: const Key('confirm_password'),
        //   duration: const Duration(milliseconds: 250),
        //   left: 0,
        //   right: 0,
        //   //top: widget.topPosition(begin ? 4 : 2),
        //   top: widget.topPosition(5),

        //   child: AnimatedOpacity(
        //     opacity: begin ? 1 : 0,
        //     duration: const Duration(milliseconds: 250),
        //     child: const PasswordField.confrimPassword(
        //       key: Key('confirm_password_field'),
        //     ),
        //   ),
        // ),
        if (!end)
          AnimatedPositioned(
            key: const Key('forgetPassword'),
            duration: const Duration(milliseconds: 250),
            left: 0,
            right: 0,
            // top: widget.topPosition(!begin ? 2 : 5) - 5.h,
            top: widget.topPosition(2) - 5.h,

            child: AnimatedOpacity(
              opacity: begin ? 0 : 1,
              duration: const Duration(milliseconds: 250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDialog<void>(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                context.l10n.forgetPassword,
                                style: kHead1Style.copyWith(
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      text: context.l10n.forgetPassword,
                      style: kBody1Style.copyWith(
                        fontSize: 13.sp,
                        color: ColorName.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (end)
          AnimatedPositioned(
            key: const Key('radio'),
            duration: const Duration(milliseconds: 250),
            left: 0,
            right: 0,
            top: widget.topPosition(!begin ? 2 : 5) - 5.h,
            child: AnimatedOpacity(
              opacity: !end ? 0 : 1,
              duration: const Duration(milliseconds: 250),
              child: Row(
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
            ),
          ),
        AnimatedPositioned(
          key: const Key('loginButton'),
          duration: const Duration(milliseconds: 250),
          left: 0,
          right: 0,
          top: widget.topPosition(!begin ? 3 : 6) + 35.h,
          child: Column(
            children: [
              BlocBuilder<RegisterBloc, LoginState>(
                // buildWhen: (previous, current) =>
                //     previous.status != current.status,

                builder: (context, state) {
                  // print('________################################');
                  // print('state.password.error');
                  // print(state.password.error);
                  // print('state.username.error');
                  // print(state.username.error);
                  // print('state.name.error');
                  // print(state.name.error);
                  Fluttertoast.cancel();
                  if (state.status == FormzStatus.submissionFailure) {
                    if (state.failureMessege.isNotEmpty) {
                      Fluttertoast.cancel().then(
                        (value) =>
                            Fluttertoast.showToast(msg: state.failureMessege),
                      );
                    }
                  }
                  return state.status == FormzStatus.submissionInProgress
                      ? const Center(child: CircularProgressIndicator())
                      : AppButton(
                          w: 119.w,
                          title: context.l10n.singUp,
                          onPressed: state.password.error == null &&
                                  state.name.error == null &&
                                  state.username.error == null
                              ? () {
                                  context
                                      .read<RegisterBloc>()
                                      .add(const LoginRegisterSubmitted());
                                }
                              : null,
                          //  () {

                          //   // Navigator.push<void>(
                          //   //   context,
                          //   //   MaterialPageRoute(
                          //   //     builder: (context) => const ConfirmLocationPage(),
                          //   //   ),
                          //   // );
                          //   //  widget.onPressed();
                          // },
                        );
                },
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: widget.topPosition(6) + 100.h,
          child: AnimatedOpacity(
            opacity: !begin ? 0 : 1,
            duration: const Duration(milliseconds: 250),
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: context.l10n.haveAccount,
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.onPressed();
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
          ),
        ),
      ],
    );
  }
}
