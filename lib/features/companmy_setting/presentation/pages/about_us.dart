import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/core/widgets/widget.dart';
import 'package:wyca/features/companmy_setting/presentation/bloc/calling_bloc.dart';
import 'package:wyca/l10n/l10n.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    final bloc = context.read<CallingBloc>();
    final state = bloc.state;
    if (state is CallingInitial) {
      bloc.add(GetComapnySettingsEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              BlocBuilder<CallingBloc, CallingState>(
                builder: (context, state) {
                  if (state is CallingLoaded) {
                    return Column(
                      children: [
                        Text(
                          context.l10n.termsAndConditions,
                          textAlign: TextAlign.center,
                          style: textStyleWithPrimaryBold.copyWith(
                            fontSize: 30,
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              '1- Terms and conditions',
                              style: textStyleWithPrimaryBold.copyWith(
                                fontSize: 25,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          context.l10n.localeName == 'ar'
                              ? (state.comapnySettingsModel.aboutUsAr ??
                                  state.comapnySettingsModel.aboutUs)
                              : state.comapnySettingsModel.aboutUs,
                          style: kBody1Style.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              '2- Privacy policy',
                              style: textStyleWithPrimaryBold.copyWith(
                                fontSize: 25,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          context.l10n.localeName == 'ar'
                              ? (state.comapnySettingsModel.privacyAr ??
                                  state.comapnySettingsModel.privacy)
                              : state.comapnySettingsModel.privacy,
                          style: kBody1Style.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              '3- ${context.l10n.aboutUs}',
                              style: textStyleWithPrimaryBold.copyWith(
                                fontSize: 25,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          context.l10n.localeName == 'ar'
                              ? (state.comapnySettingsModel.aboutUsAr ??
                                  state.comapnySettingsModel.aboutUs)
                              : state.comapnySettingsModel.aboutUs,
                          style: kBody1Style.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is CallingFailed) {
                    return Center(
                      child: Text(state.error.errorMessege),
                    );
                  }
                  if (state is CallingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Center();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
