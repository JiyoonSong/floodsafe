import 'package:floodsafe/view/add_volunteering_view.dart';
import 'package:floodsafe/view/volunteer_history_view.dart';
import 'package:floodsafe/viewmodel/volunteer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VolunteerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final volunteerViewModel =
        Provider.of<VolunteerViewModel>(context, listen: false);
    volunteerViewModel.fetchVolunteers();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Volunteer View',
          style: TextStyle(
            color: Colors.black, // 글씨색을 검정색으로 변경
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Consumer<VolunteerViewModel>(
        builder: (context, volunteerViewModel, _) {
          final volunteers = volunteerViewModel.volunteers;

          return ListView.builder(
            itemCount: volunteers.length,
            itemBuilder: (context, index) {
              final volunteer = volunteers[index];
              return ListTile(
                title: Text(volunteer.name),
                subtitle: Text(volunteer.status),
                onTap: () async {
                  if (volunteer.status == 'Close') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Registration Not Available'),
                          content: Text(
                            "Registration is not available as the status is currently 'Close'.",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    bool registered = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(volunteer.name),
                          content: SizedBox(
                            height: 200.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Content: ${volunteer.content}'),
                                Text(
                                  'Participant No: ${volunteer.participantNo}',
                                ),
                                Text('Status: ${volunteer.status}'),
                              ],
                            ),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                await volunteerViewModel
                                    .changeVolunteerUserStatus(
                                  volunteer.id,
                                  'Registered',
                                );
                                Navigator.pop(context, true);
                              },
                              child: Text('Register'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    if (registered == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VolunteerHistoryPage(),
                        ),
                      );
                    }
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VolunteerHistoryPage(),
            ),
          );
        },
        child: Icon(Icons.history),
        backgroundColor: Colors.grey,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
