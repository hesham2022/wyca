import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:wyca/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:wyca/features/auth/presentation/pages/provider/provider_sign_up_page.dart';
import 'package:wyca/features/auth/presentation/widgets/password_field.dart';
import 'package:wyca/imports.dart';

class ProviderLogin extends StatefulWidget {
  const ProviderLogin({super.key});

  @override
  State<ProviderLogin> createState() => _ProviderLoginState();
}

class _ProviderLoginState extends State<ProviderLogin> {
  final _emailfocusNode = FocusNode();
  final _passwordfocusNode = FocusNode();
  late LoginBloc _bloc;
  late LoginState _state;
  @override
  void initState() {
    _bloc = getIt<LoginBloc>();
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
                    'somthing go wrong',
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
    return BlocProvider<LoginBloc>.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: kPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/provider_login.png',
                      width: 200.h,
                      height: 180.h,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      context.l10n.loginTOYourAccount,
                      style: kBody1Style.copyWith(
                        fontSize: 22.sp,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 60.h),
                BlocBuilder<LoginBloc, LoginState>(
                  // buildWhen: (previous, current) => previous.username != current.username,
                  builder: (context, state) {
                    return TextFormField(
                      focusNode: _emailfocusNode,
                      // onChanged: (username) => context
                      //     .read<LoginBloc>()
                      //     .add(LoginUsernameChanged(username)),
                      onChanged: (p0) => context
                          .read<LoginBloc>()
                          .add(LoginEmailOrPhoneChanged(p0)),

                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset('assets/svg/profile.svg'),
                        ),
                        hintStyle:
                            const TextStyle(color: ColorName.primaryColor),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorName
                                .primaryColor, // Set the desired border color here
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorName
                                .primaryColor, // Set the desired border color here
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorName
                                .primaryColor, // Set the desired border color here
                          ),
                        ),
                        hintText: context
                            .l10n.emailOrPhoneNumber, /*Or Mobiel Number*/
                      ),
                    ).commonFild(context);
                  },
                ),
                SizedBox(height: 10.h),
                PasswordField(
                  focusNode: _passwordfocusNode,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage(),
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
                SizedBox(height: 10.h),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
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
                            onPressed: state.status == FormzStatus.invalid
                                ? null
                                : () {
                                    context
                                        .read<LoginBloc>()
                                        .add(const LoginProviderSubmitted());
                                  },
                            // onPressed: state.password.error == null && state.username.error == null
                            //     ? () {
                            //         context.read<LoginBloc>().add(const LoginProviderSubmitted());
                            //       }
                            //     : null,
                          );
                  },
                ),
                SizedBox(height: 60.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: context.l10n.youDontotHaveAccount,
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProviderSignUpPage(),
                                ),
                              );
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
