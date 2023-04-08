import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyca/core/api_config/api_constants.dart';
import 'package:wyca/di/get_it.dart';
import 'package:wyca/features/auth/domain/params/geo_near_params.dart';
import 'package:wyca/features/auth/presentation/bloc/provider_cubit.dart';
import 'package:wyca/features/provider/branches/presentation/cubit/branches_cubit.dart';
import 'package:wyca/features/provider/branches/presentation/pages/branch_on_map.dart';
import 'package:wyca/imports.dart';

class BranchesPage extends StatefulWidget {
  const BranchesPage({super.key});

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  final cubit = getIt<BranchesCubit>();
  @override
  void initState() {
    cubit.getNearBranches(
      GetNearParams(
        coordinates:
            (context.read<ProviderCubit>().state as ProviderCubitStateLoaded)
                .provider
                .address
                .coordinates,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BranchesCubit>(
      create: (context) => cubit,
      child: BlocBuilder<ProviderCubit, ProviderCubitState>(
        builder: (context, state) {
          return Scaffold(
            appBar: appBar(context, 'Branches'),
            body: Padding(
              padding: kPadding,
              child: BlocBuilder<BranchesCubit, BranchesCubitState>(
                builder: (context, state) {
                  if (state is BranchesCubitStateLoaded) {
                    return Column(
                      children: [
                        const SectionTitile(
                          'All Branche',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.providers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BranchOnMap(
                                        latlong: LatLng(
                                          state.providers[index].address
                                              .coordinates[0],
                                          state.providers[index].address
                                              .coordinates[1],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      width: 68.h,
                                      height: 68.h,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            //'https://joomly.net/frontend/web/images/googlemap/map.png',
                                            '$domain/img/providers/${state.providers[index].photo}',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        color: ColorName.primaryColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    SizedBox(width: 10.w, height: 0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // 'Egypt Mansoura',
                                            state.providers[index].address
                                                .address,
                                            style: kHead1Style.copyWith(
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '01017018250 - 01154616348',
                                            style: kBody1Style.copyWith(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is BranchesCubitStateError) {
                    return Center(
                      child: Text(
                        state.error.errorMessege,
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
