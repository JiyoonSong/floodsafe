import 'package:floodsafe/viewmodel/shelter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class ShelterView extends StatefulWidget {
  @override
  _ShelterViewState createState() => _ShelterViewState();
}

class _ShelterViewState extends State<ShelterView> {
  late ShelterViewModel _viewModel;
  LatLng? _currentLocation; // Initialize with null value

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<ShelterViewModel>(context);
    _viewModel.fetchShelters();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shelters',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Consumer<ShelterViewModel>(
        builder: (context, viewModel, _) {
          final shelters = viewModel.shelters;
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLocation ??
                  LatLng(1.5629284761337225, 103.63815745146225),
              zoom: 10.0,
            ),
            markers: shelters
                .map(
                  (shelter) => Marker(
                    markerId: MarkerId(shelter.id),
                    position: LatLng(shelter.latitude, shelter.longitude),
                    infoWindow: InfoWindow(
                      title: shelter.name,
                      snippet: 'Updated: ${shelter.updateDate.toString()}',
                    ),
                  ),
                )
                .toSet(),
          );
        },
      ),
    );
  }
}
