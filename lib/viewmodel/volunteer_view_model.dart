import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:floodsafe/model/volunteer.dart';

class VolunteerViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Volunteer> _volunteers = [];

  List<Volunteer> get volunteers => _volunteers;

  Future<void> fetchVolunteers() async {
    final snapshot = await _firestore.collection('volunteers').get();
    _volunteers =
        snapshot.docs.map((doc) => Volunteer.fromSnapshot(doc)).toList();
    notifyListeners();
  }

  Future<void> registerVolunteer({
    required String name,
    required String content,
    required int participantNo,
    required String status,
  }) async {
    await _firestore.collection('volunteers').add({
      'name': name,
      'content': content,
      'participantNo': participantNo,
      'status': status,
      'userStatus': 'Not Registered',
    });
    await fetchVolunteers();
  }

  Future<void> changeVolunteerUserStatus(
      String volunteerId, String userStatus) async {
    await _firestore
        .collection('volunteers')
        .doc(volunteerId)
        .update({'userStatus': userStatus});
    await fetchVolunteers();
  }

  List<Volunteer> getRegisteredVolunteers() {
    return _volunteers
        .where((volunteer) => volunteer.userStatus == 'Registered')
        .toList();
  }

  Future<void> changeVolunteerStatus(
      String volunteerId, String newStatus) async {
    try {
      await _firestore
          .collection('volunteers')
          .doc(volunteerId)
          .update({'status': newStatus});
      await fetchVolunteers();
    } catch (e) {
      // Handle error
      print('Failed to change volunteer status: $e');
    }
  }

  Future<void> deleteVolunteer(String volunteerId) async {
    try {
      await _firestore.collection('volunteers').doc(volunteerId).delete();
      await fetchVolunteers();
    } catch (e) {
      // Handle error
      print('Failed to delete volunteer: $e');
    }
  }
}
