import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/app/app.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/language_dropdwonfield.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/presentation/pages/login.dart';
import 'package:wyca/features/auth/presentation/pages/provider/provider_login.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/l10n/l10n.dart';

String kUserType = '';
// name: 'User',
//                   ),
//                   DropDownModel(
//                     name: 'Provider',x

void userAction({
  required VoidCallback isUser,
  required VoidCallback isProvider,
}) {
  print(kUserType);
  if (kUserType == 'User') {
    isUser();
  }
  if (kUserType == 'Provider') {
    isProvider();
  }
}

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});
  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  DropDownModel? userType;
  @override
  Widget build(BuildContext context) {
    return AppForm(
      builder: (context) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: kPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  LottieWidget(
                    Assets.lottie.animation2,
                    width: 192.h,
                    height: 192.h,
                  ),
                  AppDropDownField(
                    hint: context.l10n.chooseType,
                    title: 'choose type',
                    validator: (p0) =>
                        p0 == null ? 'Please select user type' : null,
                    items: [
                      DropDownModel(
                        name: context.l10n.user,
                        name2: 'User',
                      ),
                      DropDownModel(
                        name: context.l10n.provider,
                        name2: 'Provider',
                      ),
                    ],
                    // value: userType,
                    onChanged: (value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      userType = value;
                      kUserType = value!.name2!;
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AppDropDownField(
                    hint: context.l10n.language,
                    title: context.l10n.chooseLanguage,
                    // validator: (p0) =>
                    //     p0 == null ? 'Please select user type' : null,
                    items: const [
                      LanguageModel(
                        name: 'English',
                        local: 'en',
                      ),
                      LanguageModel(
                        name: 'عربي',
                        local: 'ar',
                      ),
                    ],
                    // value: userType,
                    onChanged: (value) {
                      App.changeLanguage(
                        context,
                        (value as LanguageModel?)!.local,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppButton(
                    title: context.l10n.next,
                    onPressed: () {
                      if (!AppForm.of(context).validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select user type'),
                          ),
                        );
                      } else {
                        userAction(
                          isUser: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          isProvider: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProviderLogin(),
                              ),
                            );
                          },
                        );

                        //  Navigator.pushNamed(context, '/$userType');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
