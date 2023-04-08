import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/domain/params/verify_forgt_otp.dart';
import 'package:wyca/features/auth/presentation/forget_password_bloc/forget_password_cubit.dart';
import 'package:wyca/features/auth/presentation/forget_password_bloc/forget_password_state.dart';
import 'package:wyca/features/auth/presentation/pages/reset_password_page.dart';
import 'package:wyca/gen/colors.gen.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _timerController = TimeController(seconds: 60);
  @override
  void initState() {
    _timerController.addListener(() {
      if (_timerController.enableResend) {
        setState(() {
          showResend = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timerController.close();
    super.dispose();
  }

  bool showResend = false;
  String code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordStateResetTokenLoaded) {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReserPasswordPage(),
                  ),
                );
              }
            },
            builder: (context, state) => Padding(
              padding: EdgeInsets.all(40.sp),
              child: Column(
                children: [
                  const SizedBox(height: 300),
                  // otp
                  Text(
                    'Enter a 4-digit code sent to your mobile number to confirm the password change',
                    textAlign: TextAlign.center,
                    style: kSemiBoldStyle.copyWith(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  PinCodeTextField(
                    appContext: context,

                    length: 6,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 45.h,
                      fieldWidth: 45.h,
                      activeColor: const Color(0xffE5E5E5),
                      inactiveColor: const Color(0xffE5E5E5),
                      activeFillColor: const Color(0xffF5F5F5),
                      selectedColor: const Color(0xffE5E5E5),
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    // backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    //    controller: textEditingController,
                    onCompleted: (v) {},
                    onChanged: (value) {
                      code = value;
                      // print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    //1234
                    beforeTextPaste: (text) {
                      print('Allowing to paste $text');
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  AppButton(
                    title: 'Send',
                    onPressed: () {
                      if (state
                          is ForgetPasswordStateForgetPasswordTokenLoaded) {
                        context
                            .read<ForgetPasswordCubit>()
                            .verifyForgetPasswordOtp(
                              VerifyForgetPasswordParam(
                                token: state.token,
                                code: code,
                              ),
                            );
                      }
                    },
                    w: 120.w,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Didn't receive a message?",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (showResend != true) {
                                setState(() {
                                  showResend = true;
                                  _timerController.inint();
                                });
                              }
                            },
                          style: kBody1Style.copyWith(
                            color: ColorName.primaryColor,
                          ),
                        ),
                      ),
                      if (showResend)
                        SizedBox(
                          width: 5.h,
                        ),
                      if (showResend)
                        ResendTime(
                          controller: _timerController,
                        )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
