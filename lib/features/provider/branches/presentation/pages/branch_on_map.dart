import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyca/core/utils/map_utils/map_helper.dart';
import 'package:wyca/imports.dart';

class BranchOnMap extends StatefulWidget {
  const BranchOnMap({super.key, required this.latlong});
  final LatLng latlong;
  @override
  State<BranchOnMap> createState() => _BranchOnMapState();
}

class _BranchOnMapState extends State<BranchOnMap> {
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
      appBar: appBar(context, 'Branh On Map'),
      body: Padding(
        padding: kPadding.copyWith(bottom: 36),
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: (controller) {
                  mapHelper
                    ..init(controller)
                    ..addMarker(widget.latlong);
                  controller.moveCamera(CameraUpdate.newLatLng(widget.latlong));
                },
                markers: mapHelper.markers,
                initialCameraPosition: mapHelper.initialPosition,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '01017018250 - 01154616348',
                  style: kHead1Style.copyWith(fontSize: 16.sp),
                ),
                const Spacer(),
                const Icon(
                  Icons.phone,
                  color: ColorName.primaryColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
