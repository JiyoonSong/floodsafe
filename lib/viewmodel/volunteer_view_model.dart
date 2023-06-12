import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floodsafe/model/volunteer.dart';
import 'package:flutter/foundation.dart';

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
    });
    await fetchVolunteers();
  }
}
