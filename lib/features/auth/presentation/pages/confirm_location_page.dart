import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyca/core/utils/map_utils/map_helper.dart';
import 'package:wyca/features/auth/presentation/pages/provider/success_sign.dart';
import 'package:wyca/features/auth/presentation/pages/user_type_screen.dart';
import 'package:wyca/features/user/home/presentation/pages/home_page.dart';
import 'package:wyca/imports.dart';

class ConfirmLocationPage extends StatefulWidget {
  const ConfirmLocationPage({super.key, this.onConfirm});
  final void Function(LatLng, Placemark placemark, String address,)? onConfirm;

  @override
  State<ConfirmLocationPage> createState() => _ConfirmLocationPageState();
}

class _ConfirmLocationPageState extends State<ConfirmLocationPage> {
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
            height: 50.h,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 40,
              right: 40,
            ),
            child: TextFormField(
              controller: mapHelper.searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'Search Location',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.location_searching),
                  onPressed: mapHelper.getLocationFromAdreees,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: GoogleMap(
              myLocationEnabled: true,
              onTap: (point) async {
                mapHelper.addMarker(point);
              },
              markers: mapHelper.markers,
              onCameraMove: (point) async {
                mapHelper.addMarker(
                  LatLng(point.target.latitude, point.target.longitude),
                );
                userAction(
                  isUser: () async {},
                  isProvider: () {
                    // context.read<RegisterProviderBloc>().add(
                    //       LoginAddAddress(
                    //         address: '',
                    //         coordinates: [
                    //           point.target.latitude,
                    //           point.target.longitude
                    //         ],
                    //       ),
                    //     );
                    // Navigator.push<void>(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const ProviderSuccessSignUp(),
                    //   ),
                    // );
                  },
                );
              },
              onMapCreated: (GoogleMapController controller) {
                mapHelper.init(controller);
                mapHelper.markers.add(
                  Marker(
                    markerId: const MarkerId('1'),
                    position: mapHelper.initialPosition.target,
                    infoWindow: const InfoWindow(
                      title: 'My Location',
                      snippet: '',
                    ),
                  ),
                );
                mapHelper.controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: mapHelper.markers.first.position,
                      zoom: 10,
                    ),
                  ),
                );
                setState(() {});
              },
              initialCameraPosition: mapHelper.initialPosition,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          AppButton(
            w: 300.w,
            h: 36.h,
            title: 'Confirm Location',
            onPressed: () async {
              final placemarks = await mapHelper.getAdressFromCurrent();
              if (!mounted) return;
              final name = placemarks.name ?? '';
              final subLocality = placemarks.subLocality ?? '';
              final locality = placemarks.locality ?? '';
              final administrativeArea = placemarks.administrativeArea ?? '';
              final postalCode = placemarks.postalCode ?? '';
              final country = placemarks.country ?? '';
              final address =
                  '$name, $subLocality, $locality, $administrativeArea $postalCode, $country';
              if (widget.onConfirm != null) {
                const l1 = 30.285390;
                const l2 = 30.172212;
                const t1 = 31.505681;
                const t2 = 31.437411;
                if ((mapHelper.markers.last.position.latitude < l2 ||
                        mapHelper.markers.last.position.latitude > l1) ||
                    (mapHelper.markers.last.position.longitude > t1 ||
                        mapHelper.markers.last.position.longitude < t2)) {
                  await Fluttertoast.showToast(
                      msg: 'this area out of our work');
                  return;
                }

                widget.onConfirm!(
                  LatLng(
                    mapHelper.markers.first.position.latitude,
                    mapHelper.markers.first.position.longitude,
                  ),
                  placemarks,
                  address,
                );
              }
              if (widget.onConfirm == null) {
                userAction(
                  isUser: () async {
                    await Navigator.push<void>(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePAGE()),
                    );
                  },
                  isProvider: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProviderSuccessSignUp(),
                      ),
                    );
                  },
                );
              }
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
