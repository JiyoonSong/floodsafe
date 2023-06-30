import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floodsafe/model/volunteer.dart';
import 'package:floodsafe/view/auth/profile_view.dart';
import 'package:floodsafe/view/channel/channel_view.dart';
import 'package:floodsafe/view/shelter_view.dart';
import 'package:floodsafe/view/volunteer_view.dart';
import 'package:floodsafe/viewmodel/channel_view_model.dart';
import 'package:floodsafe/viewmodel/shelter_view_model.dart';
import 'package:floodsafe/viewmodel/volunteer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:floodsafe/model/user.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flood Safe Mobile Application'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileView(user: widget.user),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Center(
            child: Text('Welcome ${widget.user.name}'),
          ),
          ChangeNotifierProvider(
            create: (context) => ShelterViewModel(),
            child: ShelterView(),
          ),
          ChannelView(
            viewModel: ChannelViewModel(user: widget.user),
            user: widget.user,
          ),
          ChangeNotifierProvider(
            create: (context) => VolunteerViewModel(),
            child: Consumer<VolunteerViewModel>(
              builder: (context, volunteerViewModel, _) {
                return VolunteerView();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Shelter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Channel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Volunteer',
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
      ),
    );
  }
}
