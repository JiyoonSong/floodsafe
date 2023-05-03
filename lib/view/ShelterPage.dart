import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShelterPage extends StatefulWidget {
  @override
  _ShelterPageState createState() => _ShelterPageState();
}

class _ShelterPageState extends State<ShelterPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    controller.animateCamera(CameraUpdate.newCameraPosition((CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        GoogleMap(
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition:
              CameraPosition(target: LatLng(1.572567, 103.619954), zoom: 15),
        )
      ]),
    );
  }
}
