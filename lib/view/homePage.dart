import 'package:floodsafe/view/auth/profile_view.dart';
import 'package:floodsafe/view/channel/channel_view.dart';
import 'package:floodsafe/view/shelter_view.dart';
import 'package:floodsafe/view/volunteer_view.dart';
import 'package:floodsafe/viewmodel/channel_view_model.dart';
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
  int _selectedIndex = 1;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ShelterView(),
      ChannelView(
          viewModel: ChannelViewModel(user: widget.user), user: widget.user),
      ChangeNotifierProvider(
        create: (context) => VolunteerViewModel(), // VolunteerViewModel을 제공합니다.
        child: VolunteerView(),
      ),
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index != 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _pages[index],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(_selectedIndex >= 0 && _selectedIndex < _pages.length);
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        items: [
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
