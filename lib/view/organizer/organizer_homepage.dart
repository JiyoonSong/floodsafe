import 'package:floodsafe/model/user.dart';
import 'package:flutter/material.dart';

class OrganizerPage extends StatelessWidget {
  final UserModel user;

  OrganizerPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organizer Page'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Text('Welcome, You are an organizer.'),
      ),
    );
  }
}
