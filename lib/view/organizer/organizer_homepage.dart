import 'package:floodsafe/model/user.dart';
import 'package:floodsafe/view/organizer/add_volunteering_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floodsafe/viewmodel/volunteer_view_model.dart';

class OrganizerPage extends StatelessWidget {
  final UserModel user;

  OrganizerPage({required this.user});

  @override
  Widget build(BuildContext context) {
    final volunteerViewModel = Provider.of<VolunteerViewModel>(context);
    volunteerViewModel.fetchVolunteers(); // Fetch volunteers

    return Scaffold(
      appBar: AppBar(
        title: Text('Organizer Page'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VolunteerRegistrationPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<VolunteerViewModel>(
          builder: (context, volunteerViewModel, _) {
            if (volunteerViewModel.volunteers.isEmpty) {
              return Text('No volunteers available.');
            } else {
              return ListView.builder(
                itemCount: volunteerViewModel.volunteers.length,
                itemBuilder: (context, index) {
                  final volunteer = volunteerViewModel.volunteers[index];
                  return ListTile(
                    title: Text(volunteer.name),
                    subtitle: Text(volunteer.content),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButton<String>(
                          value: volunteer.status,
                          onChanged: (String? newValue) {
                            volunteerViewModel.changeVolunteerStatus(
                              volunteer.id,
                              newValue!,
                            );
                          },
                          items: <String>[
                            'Open',
                            'Close',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            volunteerViewModel.deleteVolunteer(volunteer.id);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
