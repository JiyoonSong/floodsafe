import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floodsafe/viewmodel/volunteer_view_model.dart';

class VolunteerRegistrationPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _participantNoController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Volunteering'),
          backgroundColor: Colors.grey,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                  ),
                ),
                TextField(
                  controller: _participantNoController,
                  decoration: InputDecoration(
                    labelText: 'Participant No',
                  ),
                ),
                TextField(
                  controller: _statusController,
                  decoration: InputDecoration(
                    labelText: 'Status',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  onPressed: () {
                    final name = _nameController.text;
                    final content = _contentController.text;
                    final participantNo =
                        int.parse(_participantNoController.text);
                    final status = _statusController.text;

                    final volunteerViewModel =
                        Provider.of<VolunteerViewModel>(context, listen: false);

                    if (volunteerViewModel != null) {
                      volunteerViewModel.registerVolunteer(
                        name: name,
                        content: content,
                        participantNo: participantNo,
                        status: status,
                      );
                    }

                    Navigator.pop(context); // 이전 페이지로 돌아감

                    // OrganizerPage에서 fetchVolunteers() 호출하여 리스트 업데이트
                    final organizerViewModel =
                        Provider.of<VolunteerViewModel>(context, listen: false);
                    if (organizerViewModel != null) {
                      organizerViewModel.fetchVolunteers();
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ));
  }
}
