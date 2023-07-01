import 'package:flutter/material.dart';
import 'package:floodsafe/model/user.dart';
import 'package:floodsafe/viewmodel/auth_view_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:http/http.dart' as http;

import '../homepage.dart'; // http 패키지 import

class ProfileView extends StatefulWidget {
  final UserModel user;

  ProfileView({required this.user});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthViewModel _authViewModel = AuthViewModel();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userICController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  LatLng? _selectedLocation;

  String _currentAddress = '';

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name ?? '';
    _userICController.text = widget.user.userIC ?? '';
    _addressController.text = widget.user.place ?? '';
    _getCurrentAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email: ${widget.user.email}',
                style: TextStyle(fontSize: 16),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _userICController,
                  decoration: InputDecoration(
                    labelText: 'User IC',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                ),
              ),
              if (_selectedLocation != null)
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _selectedLocation!,
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('selectedLocation'),
                            position: _selectedLocation!,
                          ),
                        },
                      ),
                    ),
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _updateProfile();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          user: UserModel(
                            id: widget.user.id,
                            email: widget.user.email,
                            name: widget.user.name,
                            place: widget.user.place,
                            type: widget.user.type,
                          ),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey, // 회색 배경색으로 변경
                  ),
                  child: Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateProfile() async {
    String name = _nameController.text;
    String userIC = _userICController.text;
    String place = _addressController.text;
    double latitude = _selectedLocation?.latitude ?? 0.0;
    double longitude = _selectedLocation?.longitude ?? 0.0;

    UserModel updatedUser = UserModel(
      id: widget.user.id,
      email: widget.user.email,
      name: name,
      userIC: userIC,
      place: place,
      latitude: latitude,
      longitude: longitude,
    );

    bool success = await _authViewModel.updateUserProfile(updatedUser);
    if (success) {
      // 업데이트 성공 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      // 업데이트 실패 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  void _getCurrentAddress() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address =
            '${placemark.locality}, ${placemark.subLocality}, ${placemark.thoroughfare}';
        setState(() {
          _addressController.text = address;
          _selectedLocation = LatLng(position.latitude, position.longitude);
        });
      } else {
        print('No placemarks found');
      }
    } catch (e) {
      print('Failed to get current address: $e');
    }
  }

  Future<bool> _isAddressValid(String address) async {
    try {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?address=$address'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Failed to validate address: $e');
      return false;
    }
  }
}
