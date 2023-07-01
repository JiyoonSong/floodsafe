import 'package:floodsafe/model/volunteer.dart';
import 'package:floodsafe/viewmodel/volunteer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VolunteerHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final volunteerViewModel = Provider.of<VolunteerViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer History'),
        backgroundColor: Colors.grey,
      ),
      body: Consumer<VolunteerViewModel>(
        builder: (context, volunteerViewModel, _) {
          volunteerViewModel
              .fetchVolunteers(); // Fetch volunteers to ensure data is up-to-date
          final registeredVolunteers =
              volunteerViewModel.getRegisteredVolunteers();
          return ListView.builder(
            itemCount: registeredVolunteers.length,
            itemBuilder: (context, index) {
              final volunteer = registeredVolunteers[index];
              return ListTile(
                title: Text(volunteer.name),
                subtitle: Text(volunteer.status),
                onTap: () {
                  // Volunteer details page
                },
              );
            },
          );
        },
      ),
    );
  }
}
