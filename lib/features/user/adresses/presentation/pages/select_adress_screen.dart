import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyca/core/utils/map_utils/map_helper.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wyca/features/auth/presentation/bloc/user_cubit.dart';
import 'package:wyca/features/provider/new_request/presentation/pages/request_details_page.dart';
import 'package:wyca/imports.dart';

class SelectAdressScreen extends StatefulWidget {
  const SelectAdressScreen({super.key});

  @override
  State<SelectAdressScreen> createState() => _SelectAdressScreenState();
}

class _SelectAdressScreenState extends State<SelectAdressScreen> {
  final mapHelper = MapHelper();
  @override
  void initState() {
    mapHelper.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 20,
          //     right: 20,
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextFormField(
          //           controller: mapHelper.searchController,
          //           decoration: InputDecoration(
          //             // prefixIcon: widget(child: const Icon(Icons.search)),
          //             labelText: 'Search Location',
          //             suffixIcon: IconButton(
          //               icon: const Icon(Icons.search),
          //               onPressed: mapHelper.getLocationFromAdreees,
          //             ),
          //           ),
          //         ),
          //       ),
          //       // IconButton(
          //       //   icon: const Icon(Icons.location_searching),
          //       //   onPressed: () async {
          //       //     final position = await determinePosition();
          //       //     mapHelper.addMarker(
          //       //       LatLng(position.altitude, position.longitude),
          //       //     );
          //       //     await mapHelper.controller.animateCamera(
          //       //       CameraUpdate.newLatLng(
          //       //         LatLng(position.altitude, position.longitude),
          //       //       ),
          //       //     );
          //       //   },
          //       // )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppButton(
                    title: 'Current location',
                    onPressed: () async {
                      final position = await determinePosition();
                      mapHelper.addMarker(
                        LatLng(position.latitude, position.longitude),
                      );
                      await mapHelper.controller.animateCamera(
                        CameraUpdate.newLatLng(
                          LatLng(position.latitude, position.longitude),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: AppButton(
                    title: 'Work Area',
                    onPressed: () async {
                      mapHelper.addMarker(
                        const LatLng(30.22555111681319, 31.465171657209957),
                      );
                      await mapHelper.controller.animateCamera(
                        CameraUpdate.newLatLng(
                          const LatLng(30.22555111681319, 31.465171657209957),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Text(
            'Please Note The Area Of Our Work Is Obour Area',
            style: kBody1Style,
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GoogleMap(
              onCameraMove: (position) {
                mapHelper.addMarker(position.target);
              },
              myLocationEnabled: true,
              onTap: (point) async {
                mapHelper.addMarker(point);
              },
              markers: mapHelper.markers,
              onMapCreated: mapHelper.init,
              initialCameraPosition: mapHelper.initialPosition,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          BlocBuilder<UserCubit, UserCubitState>(
            builder: (context, state) {
              if (state is UserCubitStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return AppButton(
                w: 300.w,
                h: 36.h,
                title: context.l10n.addNewAdress,
                onPressed: () async {
                  // 30.285390, 31.476819
                  const l1 = 30.285390;
                  const l2 = 30.172212;
                  const t1 = 31.505681;
                  const t2 = 31.437411;
                  if ((mapHelper.markers.last.position.latitude < l2 ||
                          mapHelper.markers.last.position.latitude > l1) ||
                      (mapHelper.markers.last.position.longitude > t1 ||
                          mapHelper.markers.last.position.longitude < t2)) {
                    await Fluttertoast.showToast(
                      msg: 'this area out of our work',
                    );
                    return;
                  }

                  final placeMark = await mapHelper.getAdressFromCurrent();
                  if (!mounted) return;
                  final name = placeMark.name ?? '';
                  final subLocality = placeMark.subLocality ?? '';
                  final locality = placeMark.locality ?? '';
                  final administrativeArea = placeMark.administrativeArea ?? '';
                  final postalCode = placeMark.postalCode ?? '';
                  final country = placeMark.country ?? '';
                  final address =
                      '$name, $subLocality, $locality, $administrativeArea $postalCode, $country';
                  await showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AddressDesc(
                        address: address,
                        mapHelper: mapHelper,
                      );
                    },
                  );
                  // context.read<AuthenticationBloc>().add(
                  //       UpdateAddresses(
                  //         Address(
                  //           id: '',
                  //           address: address,
                  //           description: ,
                  //           coordinates: [
                  //             mapHelper.markers.last.position.latitude,
                  //             mapHelper.markers.last.position.longitude,

                  //           ],
                  //         ),
                  //       ),
                  //     );

                  // Navigator.pop<String>(
                  //   context,
                  //   '',
                  // );
                },
              );
            },
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}

class AddressDesc extends StatefulWidget {
  const AddressDesc({
    super.key,
    required this.address,
    required this.mapHelper,
  });

  final String address;
  final MapHelper mapHelper;

  @override
  State<AddressDesc> createState() => _AddressDescState();
}

class _AddressDescState extends State<AddressDesc> {
  final textController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _fromKey,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: SizedBox(
          height: ScreenUtil().setHeight(320),
          width: ScreenUtil().setWidth(320),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Submit Your Address',
                      style: kHead1Style.copyWith(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: textController,
                  minLines: 4,
                  maxLines: 5,
                  validator: (value) => value!.isEmpty
                      ? 'Please Write your address description'
                      : null,
                  decoration: InputDecoration(
                    hintText: 'Write You Addres Description',
                    contentPadding: const EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                AppButton(
                  h: 40.h,
                  title: 'Confirm',
                  onPressed: () {
                    if (!_fromKey.currentState!.validate()) return;
                    context.read<AuthenticationBloc>().add(
                          UpdateAddresses(
                            Address(
                              id: '',
                              address: widget.address,
                              description: textController.text,
                              coordinates: [
                                widget.mapHelper.markers.last.position.latitude,
                                widget
                                    .mapHelper.markers.last.position.longitude,
                              ],
                            ),
                          ),
                        );

                    Navigator.pop<String>(
                      context,
                      '',
                    );
                    Navigator.pop<String>(
                      context,
                      '',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
