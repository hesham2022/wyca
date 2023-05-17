import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/user/adresses/presentation/pages/select_adress_screen.dart';
import 'package:wyca/features/user/adresses/presentation/widgets/location_widget.dart';
import 'package:wyca/global_data.dart';
import 'package:wyca/imports.dart';

class AdressesPage extends StatefulWidget {
  const AdressesPage({super.key});

  @override
  State<AdressesPage> createState() => _AdressesPageState();
}

class _AdressesPageState extends State<AdressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.myAdresses),
      ),
      body: BlocBuilder<UserCubit, UserCubitState>(
        builder: (context, state) {
          if (state is UserCubitStateLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    for (var i in state.user.addresses)
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context.read<UserCubit>().deleteAddress(i.id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Expanded(
                                child: LocationWidget(
                                  address: i,
                                  controller: TextEditingController()
                                    ..text = i.description ?? i.address,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      ),
                    AppButton(
                      w: 150.w,
                      h: 36.h,
                      title: context.l10n.addNewAdress,
                      onPressed: () async {
                        final newAdress = await Navigator.push<String>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectAdressScreen(),
                          ),
                        );
                        setState(() {
                          kLocations.add(newAdress!);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is UserCubitStateLoading) {
            return const Center(
              child: Loader(),
            );
          }
          if (state is UserCubitStateError) {
            return Center(
              child: Text(state.error.errorMessege),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
