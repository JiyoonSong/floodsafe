import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

class ShelterView extends StatefulWidget {
  @override
  _ShelterViewState createState() => _ShelterViewState();
}

class _ShelterViewState extends State<ShelterView> {
  // late GoogleMapController _mapController;
  // late LocationData _currentLocation;
  // Location _location = Location();

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  //Future<void> _getCurrentLocation() async {
  //   final locationData = await _location.getLocation();
  //   setState(() {
  //     _currentLocation = locationData;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shelter'),
      ),
      // body: Stack(
      //   children: [
      //     GoogleMap(
      //       initialCameraPosition: CameraPosition(
      //         target: LatLng(
      //           _currentLocation.latitude ?? 37.7749,
      //           _currentLocation.longitude ?? -122.4194,
      //         ),
      //         zoom: 14,
      //       ),
      //       onMapCreated: (controller) {
      //         setState(() {
      //           _mapController = controller;
      //         });
      //       },
      //       myLocationEnabled: true,
      //     ),
      //     Align(
      //       alignment: Alignment.bottomRight,
      //       child: Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: FloatingActionButton(
      //           onPressed: () {
      //             _mapController.animateCamera(
      //               CameraUpdate.newCameraPosition(
      //                 CameraPosition(
      //                   target: LatLng(
      //                     _currentLocation.latitude ?? 37.7749,
      //                     _currentLocation.longitude ?? -122.4194,
      //                   ),
      //                   zoom: 14,
      //                 ),
      //               ),
      //             );
      //           },
      //           child: Icon(Icons.my_location),
      //         ),
      //       ),
      //     ),
      //   ],
      //),
    );
  }
}
