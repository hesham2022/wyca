import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/core/theme/theme.dart';
import 'package:wyca/features/companmy_setting/presentation/bloc/calling_bloc.dart';
import 'package:wyca/l10n/l10n.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            BlocBuilder<CallingBloc, CallingState>(
              builder: (context, state) {
                if (state is CallingLoaded) {
                  return Text(
                    context.l10n.localeName == 'ar'
                        ? (state.comapnySettingsModel.privacyAr ??
                            state.comapnySettingsModel.privacy)
                        : state.comapnySettingsModel.privacy,
                    style: kBody1Style.copyWith(
                      color: Colors.purple,
                    ),
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
    );
  }
}
