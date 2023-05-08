// // extension AppFormField

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:wyca/features/auth/presentation/widgets/login_from_builder.dart';
import 'package:wyca/features/auth/presentation/widgets/sign_from_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool p = true;
  bool disappear = true;

  @override
  Widget build(BuildContext context) {
    final starterPosition = p ? (250.h) : 250.h;
    final space = 10.h;
    final textFiedHeight = kTextFieldHeight;
    double topPosition(int index) =>
        starterPosition + ((textFiedHeight * index) + (space * index));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (_) => getIt(),
          ),
          BlocProvider<RegisterBloc>(
            create: (_) => getIt(),
          ),
        ],
        child: Center(
          child: Padding(
            padding: kPadding,
            child: !p
                ? SignFormBuilder(
                    onPressed: () {
                      setState(() {
                        p = !p;
                        disappear = !p;
                      });
                    },
                    topPosition: topPosition,
                  )
                : LoginFormBuilder(
                    onPressed: () {
                      setState(() {
                        p = !p;
                        disappear = !p;
                        // showConfirmPassword = !showConfirmPassword;
                      });
                    },
                    topPosition: topPosition,
                  ),
          ),
        ),
      ),
    );
  }
}
