import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:wyca/gen/assets.gen.dart';
import 'package:wyca/gen/colors.gen.dart';
import 'package:wyca/l10n/l10n.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.confrimPassword = false,
    this.controller,
    this.focusNode,
  });
  const PasswordField.confrimPassword({
    super.key,
    this.controller,
    this.focusNode,
  }) : confrimPassword = true;
  final bool confrimPassword;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          focusNode: widget.focusNode,
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          controller: _controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: ColorName.primaryColor),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    ColorName.primaryColor, // Set the desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    ColorName.primaryColor, // Set the desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    ColorName.primaryColor, // Set the desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 5.h,
              ),
              child: !_obscureText
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = true;
                        });
                      },
                      child: Assets.svg.visible.svg(
                        allowDrawingOutsideViewBox: true,
                        width: 10.w,
                        height: 10.h,
                        color: ColorName.primaryColor,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = false;
                        });
                      },
                      child: Assets.svg.nonVisibile.svg(
                        allowDrawingOutsideViewBox: true,
                        width: 10.w,
                        height: 10.h,
                        color: ColorName.primaryColor,
                      ),
                    ),
            ),
            hintText: widget.confrimPassword
                ? context.l10n.confirmPassword
                : context.l10n.password,
          ),
        ).commonFild(context);
      },
    );
  }
}

class PasswordRegisterField extends StatefulWidget {
  const PasswordRegisterField({
    super.key,
    this.confrimPassword = false,
    this.controller,
    this.focusNode,
  });
  const PasswordRegisterField.confrimPassword({
    super.key,
    this.controller,
    this.focusNode,
  }) : confrimPassword = true;
  final bool confrimPassword;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  @override
  State<PasswordRegisterField> createState() => _PasswordRegisterFieldState();
}

class _PasswordRegisterFieldState extends State<PasswordRegisterField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        if (state.password.invalid == true) {
          Fluttertoast.cancel().then((value) {
            Fluttertoast.showToast(
              msg: state.password.errorText(state.password.error) ??
                  'somthing go wrong',
            );
          });
        } else {
          Fluttertoast.cancel();
        }
        return TextFormField(
          focusNode: _focusNode,
          onChanged: (password) =>
              context.read<RegisterBloc>().add(LoginPasswordChanged(password)),
          controller: _controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    ColorName.primaryColor, // Set the desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    ColorName.primaryColor, // Set the desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    ColorName.primaryColor, // Set the desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 5.h,
              ),
              child: !_obscureText
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = true;
                        });
                      },
                      child: Assets.svg.visible.svg(
                        allowDrawingOutsideViewBox: true,
                        width: 10.w,
                        height: 10.h,
                        color: ColorName.primaryColor,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = false;
                        });
                      },
                      child: Assets.svg.nonVisibile.svg(
                        allowDrawingOutsideViewBox: true,
                        width: 10.w,
                        height: 10.h,
                        color: ColorName.primaryColor,
                      ),
                    ),
            ),
            hintText: widget.confrimPassword
                ? context.l10n.confirmPassword
                : context.l10n.password,
          ),
        ).commonFild(context);
      },
    );
  }
}

class PasswordRegisterProviderField extends StatefulWidget {
  const PasswordRegisterProviderField({
    super.key,
    this.confrimPassword = false,
    this.controller,
    this.focusNode,
  });
  const PasswordRegisterProviderField.confrimPassword({
    super.key,
    this.controller,
    this.focusNode,
  }) : confrimPassword = true;
  final bool confrimPassword;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  @override
  State<PasswordRegisterProviderField> createState() =>
      _PasswordRegisterProviderFieldtate();
}

class _PasswordRegisterProviderFieldtate
    extends State<PasswordRegisterProviderField> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterProviderBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          focusNode: widget.focusNode,
          onChanged: (password) => context
              .read<RegisterProviderBloc>()
              .add(LoginPasswordChanged(password)),
          controller: _controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    ColorName.primaryColor, // Set the desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    ColorName.primaryColor, // Set the desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    ColorName.primaryColor, // Set the desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 5.h,
              ),
              child: !_obscureText
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = true;
                        });
                      },
                      child: Assets.svg.visible.svg(
                        allowDrawingOutsideViewBox: true,
                        width: 10.w,
                        height: 10.h,
                        color: ColorName.primaryColor,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          _obscureText = false;
                        });
                      },
                      child: Assets.svg.nonVisibile.svg(
                        allowDrawingOutsideViewBox: true,
                        width: 10.w,
                        height: 10.h,
                        color: ColorName.primaryColor,
                      ),
                    ),
            ),
            hintText: widget.confrimPassword
                ? context.l10n.confirmPassword
                : context.l10n.password,
          ),
        ).commonFild(context);
      },
    );
  }
}
