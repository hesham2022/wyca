import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/routing/routes.gr.dart';
import 'package:wyca/core/theme/app_theme.dart';
import 'package:wyca/core/utils/validation_regx.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/domain/params/reset_password_params.dart';
import 'package:wyca/features/auth/presentation/forget_password_bloc/forget_password_cubit.dart';
import 'package:wyca/features/auth/presentation/forget_password_bloc/forget_password_state.dart';
import 'package:wyca/gen/assets.gen.dart';

class ReserPasswordPage extends StatefulWidget {
  const ReserPasswordPage({super.key});

  @override
  State<ReserPasswordPage> createState() => _ReserPasswordPageState();
}

class _ReserPasswordPageState extends State<ReserPasswordPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmCasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                listener: (context, state) {
                  if (state is ForgetPasswordStateResetPasswordSuccess) {
                    context.router.pushAndPopUntil(
                      const LoginRoute(),
                      predicate: (v) => false,
                    );
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: kPadding,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100.h,
                        ),
                        LottieWidget(
                          height: 180.h,
                          width: 180.h,
                          Assets.lottie.animation7,
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Text(
                          'PASSWORD RESET',
                          style: kHead1Style.copyWith(
                            fontSize: 22.sp,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter a new password';
                            }
                            if (value.length < 8) {
                              return 'pasword should be at least 8 characters';
                            }
                            if (!ValidationsPatterns.conCharacter
                                .hasMatch(value)) {
                              return '''password should contain at least one letter''';
                            }
                            if (!ValidationsPatterns.contDigit
                                .hasMatch(value)) {
                              return '''password should contain at least one number''';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(Icons.lock_clock_sharp),
                          ),
                        ).commonFild(context),
                        SizedBox(
                          height: 12.h,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != passwordController.text) {
                              return 'not identical password';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock_clock_sharp),
                          ),
                        ).commonFild(context),
                        SizedBox(
                          height: 35.h,
                        ),
                        AppButton(
                          w: 120.w,
                          title: 'Confirm',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (state
                                  is ForgetPasswordStateResetTokenLoaded) {
                                context
                                    .read<ForgetPasswordCubit>()
                                    .resetPassword(
                                      ResetPasswordParams(
                                        password: passwordController.text,
                                        token: state.token,
                                      ),
                                    );
                              }
                            }

                            // Navigator.pushAndRemoveUntil<void>(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => const LoginPage(),
                            //   ),
                            //   (route) => false,
                            // );
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
}
