import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:wyca/imports.dart';
import 'package:wyca/core/utils/map_utils/map_helper.dart';

class AmbientSpacePage extends StatefulWidget {
  const AmbientSpacePage({super.key});

  @override
  State<AmbientSpacePage> createState() => _AmbientSpacePageState();
}

class _AmbientSpacePageState extends State<AmbientSpacePage> {
  final _mapHelper = MapHelper();
  @override
  void initState() {
    _mapHelper.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Ambient Space'),
      body: Padding(
        padding: kPadding,
        child: Column(
          children: [
            const SectionTitile(
              'Ambient Space',
              color: Colors.black,
            ),
            SizedBox(height: 10.h),
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.location_pin),
                labelText: '3km',
                labelStyle: kHead1Style.copyWith(
                  fontSize: 14.sp,
                ),
              ),
              style: kSemiBoldStyle.copyWith(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const SectionTitile(
              'Ambient Space On The Map',
              color: Colors.black,
            ),
            SizedBox(height: 10.h),
            Container(
              width: 300.h,
              height: 190.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: GoogleMap(
                myLocationEnabled: true,
                onTap: (point) async {
                  _mapHelper.addMarker(point);
                },
                markers: _mapHelper.markers,
                onCameraMove: (point) {},
                onMapCreated: (controller) {
                  _mapHelper
                    ..init(controller)
                    ..addMarker(const LatLng(30, 31));
                  _mapHelper.controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                          _mapHelper.markers.first.position.latitude,
                          _mapHelper.markers.first.position.longitude,
                        ),
                        zoom: 15,
                      ),
                    ),
                  );
                },
                initialCameraPosition: _mapHelper.initialPosition,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            AppButton(
              h: 36.h,
              title: 'Expand The Scope Of Work',
              onPressed: () {
                // show dialog
                showDialog<void>(
                  context: context,
                  builder: (context) => Dialog(
                    child: Container(
                      height: 250.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Lottie.asset(Assets.lottie.animation5),
                            const SectionTitile('Reason'),
                            AppDropDownField(
                              items: const [
                                DropDownModel(name: 'Reason 1'),
                                DropDownModel(name: 'Reason 2'),
                              ],
                              onChanged: (v) {},
                              hint: 'Reason',
                            ).build(context),
                            SizedBox(height: 10.h),
                            AppButton(
                              h: 36.h,
                              title: 'Send',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
