import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floodsafe/view/homePage.dart';
import 'package:floodsafe/view/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: homePage(), title: "Flood Safe Mobile Application");
  }
  // late GoogleMapController mapController;

  // final LatLng _center = const LatLng(45.521563, -122.677433);

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         title: const Text('Maps Sample App'),
  //         backgroundColor: Colors.green[700],
  //       ),
  //       body: GoogleMap(
  //         onMapCreated: _onMapCreated,
  //         initialCameraPosition: CameraPosition(
  //           target: _center,
  //           zoom: 11.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
