import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:wyca/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:wyca/features/auth/presentation/widgets/login_bar.dart';
import 'package:wyca/features/auth/presentation/widgets/password_field.dart';
import 'package:wyca/gen/colors.gen.dart';
import 'package:wyca/l10n/l10n.dart';

class LoginFormBuilder extends StatefulWidget {
  const LoginFormBuilder({
    super.key,
    required this.topPosition,
    required this.onPressed,
  });
  final double Function(int index) topPosition;
  final VoidCallback onPressed;
  @override
  State<LoginFormBuilder> createState() => _LoginFormBuilderState();
}

class _LoginFormBuilderState extends State<LoginFormBuilder> {
  final _emailfocusNode = FocusNode();
  final _passwordfocusNode = FocusNode();
  late LoginBloc _bloc;
  late LoginState _state;
  @override
  void initState() {
    _bloc = context.read<LoginBloc>();
    _state = _bloc.state;
    _bloc.stream.listen((state) {
      _state = state;
    });
    // _emailfocusNode.addListener(
    //   () {
    //     print('listen');
    //     if (!_emailfocusNode.hasFocus) {
    //       if (_state.username.invalid == true || _state.username.pure) {
    //         Fluttertoast.cancel().then((value) {
    //           Fluttertoast.showToast(
    //             msg: _state.username.errorText(_state.username.error) ?? 'somthing go wrong',
    //           );
    //         });
    //       }
    //     }
    //   },
    // );
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
        if (!end) ...[
          Positioned(
            left: 0,
            right: 0,
            top: widget.topPosition(0),
            child: AnimatedOpacity(
              opacity: begin ? 0 : 1,
              duration: const Duration(milliseconds: 1000),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField().commonFild(context),
                  ),
                  Expanded(
                    child: TextFormField().commonFild(context),
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            left: 0,
            right: 0,
            top: widget.topPosition(1),
            child: AnimatedOpacity(
              opacity: !begin ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: context.l10n.email,
                ),
              ).commonFild(context),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            left: 0,
            right: 0,
            top: widget.topPosition(2),
            child: AnimatedOpacity(
              opacity: !begin ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: TextFormField().commonFild(context),
            ),
          ),
        ],

        ///
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
          top: begin ? 60.h : 30.h,
          child: LogoBar(
            title: context.l10n.loginTOYourAccount,
          ),
        ),
        BlocBuilder<LoginBloc, LoginState>(
          // buildWhen: (previous, current) => previous.username != current.username,
          builder: (context, state) {
            return AnimatedPositioned(
              key: const Key('emial_or_phone'),
              duration: const Duration(milliseconds: 250),
              left: 0,
              right: 0,
              top:
                  !begin ? widget.topPosition(1) - 50.h : widget.topPosition(1),
              child: TextFormField(
                focusNode: _emailfocusNode,
                decoration: InputDecoration(
                  hintText:
                      context.l10n.emailOrPhoneNumber, /*Or Mobiel Number*/
                ),
                onChanged: (p0) =>
                    context.read<LoginBloc>().add(LoginEmailOrPhoneChanged(p0)),
                // onChanged: (username) => context
                //     .read<LoginBloc>()
                //     .add(LoginUsernameChanged(username)),
              ).commonFild(context),
            );
          },
        ),
        AnimatedPositioned(
          key: const Key('password'),
          duration: const Duration(milliseconds: 250),
          left: 0,
          right: 0,
          top: widget.topPosition(!begin ? 3 : 2),
          child: PasswordField(
            focusNode: _passwordfocusNode,
          ), //exist
        ),
        if (!end)
          AnimatedPositioned(
            key: const Key('confirm_password'),
            duration: const Duration(milliseconds: 250),
            left: 0,
            right: 0,
            //   top: widget.topPosition(!begin ? 4 : 2),
            top: widget.topPosition(5),

            child: AnimatedOpacity(
              opacity: !begin ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: const PasswordField.confrimPassword(
                key: Key('confirm_password_field'),
              ),
            ),
          ),
        AnimatedPositioned(
          key: const Key('forgetPassword'),
          duration: const Duration(milliseconds: 250),
          left: 0,
          right: 0,
          //   top: widget.topPosition(begin ? 2 : 5) - 5.h,
          top: widget.topPosition(3) - 5.h,

          child: AnimatedOpacity(
            opacity: !begin ? 0 : 1,
            duration: const Duration(milliseconds: 250),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
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
        AnimatedPositioned(
          key: const Key('loginButton'),
          duration: const Duration(milliseconds: 250),
          left: 0,
          right: 0,
          top: widget.topPosition(begin ? 3 : 6) + 35.h,
          child: Column(
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                // buildWhen: (previous, current) => previous.status != current.status,
                builder: (context, state) {
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
                          title: context.l10n.login,
                          onPressed: state.status == FormzStatus.invalid ||
                                  state.status == FormzStatus.pure
                              ? () {
                                  if (state.emailOrPhone.pure) {
                                    context.read<LoginBloc>().add(
                                          const LoginEmailOrPhoneChanged(''),
                                        );
                                  }
                                  if (state.password.pure) {
                                    context.read<LoginBloc>().add(
                                          const LoginPasswordChanged(''),
                                        );
                                  }
                                  if (state.emailOrPhone.invalid) {
                                    Fluttertoast.showToast(
                                      msg: state.emailOrPhone.errorText(
                                            state.emailOrPhone.error,
                                          ) ??
                                          'invalid',
                                    );
                                    return;
                                  }

                                  if (state.password.invalid) {
                                    Fluttertoast.showToast(
                                      msg: state.password.errorText(
                                            state.password.error,
                                          ) ??
                                          'invalid',
                                    );
                                  }
                                }
                              : () {
                                  context
                                      .read<LoginBloc>()
                                      .add(const LoginSubmitted());
                                },
                          //  () {
                          //   // Navigator.push<void>(
                          //   //   context,
                          //   //   MaterialPageRoute(
                          //   //     builder: (context) => const ConfirmLocationPage(),
                          //   //   ),
                          //   // );
                          // },
                        );
                },
              ),
            ],
          ),
        ),
        // rich text
        Positioned(
          left: 0,
          right: 0,
          top: widget.topPosition(3) + 100.h,
          child: Center(
            child: RichText(
              text: TextSpan(
                text: context.l10n.youDontotHaveAccount,
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        widget.onPressed();
                      },
                    text: context.l10n.singUp,
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
        if (!end)
          Positioned(
            left: 0,
            right: 0,
            top: widget.topPosition(6) + 100.h,
            child: AnimatedOpacity(
              opacity: begin ? 0 : 1,
              duration: const Duration(milliseconds: 250),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: context.l10n.youDontotHaveAccount,
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
