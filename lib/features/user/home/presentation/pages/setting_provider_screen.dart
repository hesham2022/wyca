import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wyca/core/local_storage/secure_storage_instance.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/auth/domain/params/update_user.params.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/auth/presentation/bloc/provider_cubit.dart';
import 'package:wyca/features/auth/presentation/login_bloc/login_bloc.dart';
import 'package:wyca/features/user/home/presentation/widgets/setting_field_widget.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/l10n/l10n.dart';

class SettingProviderPage extends StatefulWidget {
  const SettingProviderPage({super.key});

  @override
  State<SettingProviderPage> createState() => _SettingProviderPageState();
}

class _SettingProviderPageState extends State<SettingProviderPage> {
  String _pass = '';
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void initState() {
    Storage.getPassword().then((value) {
      setState(() {
        if (value != null) {
          _pass = value;
          passwordController.text = _pass;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderCubitState>(
      listener: (context, state) {
        if (state is ProviderCubitStateLoaded) {
          Fluttertoast.showToast(
            msg: 'updated successfuly ',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: ColorName.primaryColor,
            textColor: Colors.white,
            fontSize: 16,
          );

          Storage.setPassword(passwordController.text);
        }
      },
      builder: (context, state) {
        if (state is ProviderCubitStateLoaded) {
          nameController.text = state.provider.name;
          emailController.text = state.provider.email;
        }

        return Scaffold(
          appBar: appBar(context, context.l10n.settings),
          body: Padding(
            padding: kPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingFieldWidget(
                  hint:  context.l10n.name,
                  controller: nameController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SettingFieldWidget(
                  hint:  context.l10n.email,
                  controller: emailController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                // SettingFieldWidget(
                //   hint: 'Phone Number',
                //   controller: TextEditingController()..text = '0101234567',
                // ),
                // SizedBox(
                //   height: 20.h,
                // ),
                BlocProvider<LoginBloc>(
                  create: (_) => getIt(),
                  child: SettingFieldWidget(
                    isPassword: true,
                    hint: context.l10n.password,
                    controller: passwordController,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return AppButton(
                      title: context.l10n.save,
                      onPressed: () async {
                        context.read<AuthenticationBloc>().add(
                              AuthenticationProviderUpdateRequested(
                                UpdateProviderParameter(
                                  provider: state.provider!.copyWith(
                                    email: emailController.text,
                                    name: nameController.text,
                                  ),
                                  password: passwordController.text,
                                ),
                              ),
                            );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
