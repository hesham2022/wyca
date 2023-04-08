import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/utils/validation_regx.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/domain/params/forget_password_params.dart';
import 'package:wyca/features/auth/presentation/forget_password_bloc/forget_password_cubit.dart';
import 'package:wyca/features/auth/presentation/forget_password_bloc/forget_password_state.dart';
import 'package:wyca/features/auth/presentation/pages/verification_page.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/l10n/l10n.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    // Future.delayed(const Duration(), showOverly);

    super.initState();
  }

  final controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ForgetPasswordStateForgetPasswordTokenLoaded) {
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => const VerificationPage(),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              child: Padding(
                padding: kPadding,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100.h,
                      ),
                      LottieWidget(
                        Assets.lottie.animation4,
                        width: 180.h,
                        height: 180.h,
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      Text(context.l10n.forgetPassword, style: kHead1Style),
                      SizedBox(
                        height: 22.h,
                      ),
                      Text(
                        context.l10n.otpHint,
                        style: kBody1Style,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      TextFormField(
                        controller: controller,
                        validator: (v) {
                          const patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          final regExp = RegExp(patttern);
                          if (v!.isEmpty) {
                            return 'please enter your email or Phone Number';
                          }
                          if (!ValidationsPatterns.emailValidate.hasMatch(v) &&
                              !regExp.hasMatch(v)) {
                            return 'Inavlid Email And Phone Number';
                            // return ValidationsPatterns.emailValidate.hasMatch(v) ? null : 'invalid email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          // errorText: 'Please enter your emil',
                          hintText: context.l10n.email,
                        ),
                      ).commonFild(context),
                      SizedBox(
                        height: 24.h,
                      ),
                      BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                        builder: (context, state) {
                          if (state is ForgetPasswordStateLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return AppButton(
                            w: 120.w,
                            h: 36.h,
                            title: context.l10n.send,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await context
                                    .read<ForgetPasswordCubit>()
                                    .forgetPassword(
                                      ForgetPasswordParam(
                                        email: controller.text.contains('@')
                                            ? controller.text
                                            : null,
                                        phoneNumber:
                                            !controller.text.contains('@')
                                                ? phoneNumberFormatter(
                                                    controller.text,
                                                  )
                                                : null,
                                      ),
                                    );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String phoneNumberFormatter(String value) {
  if (!value.startsWith('+') && value.startsWith('2')) return '+$value';
  if (!value.startsWith('+2')) return '+2$value';

  return value;
}
