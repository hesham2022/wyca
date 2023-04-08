import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wyca/core/utils/map_utils/map_helper.dart';
import 'package:wyca/features/auth/data/models/user_model.dart';
import 'package:wyca/imports.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key, required this.address});
  final Address address;
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final googeHelper = MapHelper();
  @override
  void initState() {
    googeHelper.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, widget.address.description ?? ''),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(widget.address.address ?? ''),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GoogleMap(
                markers: googeHelper.markers,
                onTap: (argument) {
                  // googeHelper.addMarker(
                  //   LatLng(
                  //     argument.latitude,
                  //     argument.longitude,
                  //   ),
                  // );
                },
                onMapCreated: (controller) {
                  googeHelper
                    ..init(controller)
                    ..addMarker(
                      LatLng(
                        widget.address.coordinates[0],
                        widget.address.coordinates[1],
                      ),
                    );
                  googeHelper.controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                          widget.address.coordinates[0],
                          widget.address.coordinates[1],
                        ),
                        zoom: 15,
                      ),
                    ),
                  );
                },
                initialCameraPosition: googeHelper.initialPosition,
              ),
            ),
            AppButton(
              title: 'Center Loctation',
              h: 20,
              onPressed: () {
                googeHelper.controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(
                        widget.address.coordinates[0],
                        widget.address.coordinates[1],
                        // googeHelper.markers.first.position.longitude,
                      ),
                      zoom: 18,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
