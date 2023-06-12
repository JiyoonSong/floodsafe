import 'package:floodsafe/viewmodel/volunteer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VolunteerRegistrationPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _participantNoController =
      TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // SafeArea 추가
      child: Consumer<VolunteerViewModel>(
        builder: (context, volunteerViewModel, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey,
              title: Text('Register Volunteer'),
            ),
            body: Padding(
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
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.grey), // 원하는 색상으로 변경
                    ),
                    onPressed: () {
                      final name = _nameController.text;
                      final content = _contentController.text;
                      final participantNo =
                          int.parse(_participantNoController.text);
                      final status = _statusController.text;
                      volunteerViewModel.registerVolunteer(
                        name: name,
                        content: content,
                        participantNo: participantNo,
                        status: status,
                      );
                      Navigator.pop(context);
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
