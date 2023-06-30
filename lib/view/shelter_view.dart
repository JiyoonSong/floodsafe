import 'package:floodsafe/viewmodel/shelter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ShelterView extends StatefulWidget {
  @override
  _ShelterViewState createState() => _ShelterViewState();
}

class _ShelterViewState extends State<ShelterView> {
  late ShelterViewModel _viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _viewModel = Provider.of<ShelterViewModel>(context);
    _viewModel.fetchShelters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shelters',
          style: TextStyle(
            color: Colors.black, // 글씨색을 검정색으로 변경
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Consumer<ShelterViewModel>(
        builder: (context, viewModel, _) {
          final shelters = viewModel.shelters;
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.5, 127.0), // 시작 위치
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
