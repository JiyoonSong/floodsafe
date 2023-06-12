import 'package:flutter/material.dart';
import '../../model/user.dart';

class AdminPage extends StatelessWidget {
  final UserModel user;

  AdminPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Text('Welcome, You are an admin.'),
      ),
    );
  }
}
