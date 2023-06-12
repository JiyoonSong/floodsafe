import 'package:floodsafe/view/add_volunteering_view.dart';
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
        backgroundColor: Colors.white,
        title: Text(
          'Volunteer Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // 검정색으로 변경
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                onTap: () {
                  showDialog(
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
                                  'Participant No: ${volunteer.participantNo}'),
                              Text('Status: ${volunteer.status}'),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.grey), // 원하는 색상으로 변경
                            ),
                            onPressed: () {
                              // Register 버튼을 누를 때 register successfully 메시지를 보여줍니다.
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Register'),
                                    content: Text('Register successfully'),
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
                            },
                            child: Text('Register'),
                          ),
                        ],
                      );
                    },
                  );
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
              builder: (context) => ChangeNotifierProvider<VolunteerViewModel>(
                create: (_) => VolunteerViewModel(),
                child: VolunteerRegistrationPage(),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
