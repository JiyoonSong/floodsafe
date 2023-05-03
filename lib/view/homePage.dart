import 'dart:async';

import 'package:floodsafe/app_navigator.dart';
import 'package:floodsafe/view/ChannelPage.dart';
import 'package:floodsafe/view/ShelterPage.dart';
import 'package:floodsafe/view/loginPage.dart';
import 'package:floodsafe/view/signUpPage.dart';
import 'package:floodsafe/viewmodel/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  @override
  _homePage createState() => _homePage();
}

class _homePage extends State<homePage> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _all();
  }

  void _all() async {}

  void _navigateToSignUpPage(BuildContext context) async {
    final bool isRegistered = await AppNavigator.navigateToSignUpPage(context);
    if (isRegistered) {
      AppNavigator.navigateToLoginPage(context);
    }
  }

  void _navigateToLoginPage(BuildContext context) async {
    final bool islogin = await AppNavigator.navigateToLoginPage(context);
    if (islogin) {
      //go to home page
    }
  }

  void _navigateToShelterPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShelterPage()));
  }

  void _navigateToChannelPage(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChannelPage()));
  }

  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flood Safe"), backgroundColor: Colors.grey),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(child: Text("Menu")),
          ListTile(title: Text("Home")),
          ListTile(
              title: Text("Register"),
              onTap: () {
                _navigateToSignUpPage(context);
              }),
          ListTile(
              title: Text("Login"),
              onTap: () {
                _navigateToLoginPage(context);
              }),
          ListTile(
              title: Text("Shelter"),
              onTap: () async {
                _navigateToShelterPage(context);
              }),
          ListTile(
            title: Text("Channel"),
            onTap: () {
              _navigateToChannelPage(context);
            },
          ),

          // ListTile(title: Text("Logout"), onTap: () async {})
        ],
      )),
      body: Stack(children: <Widget>[
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(1.572567, 103.619954), zoom: 15),
        )
      ]),
    );
  }
}
