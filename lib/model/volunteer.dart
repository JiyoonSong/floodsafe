import 'package:cloud_firestore/cloud_firestore.dart';

class Volunteer {
  final String id;
  final String name;
  final String content;
  final int participantNo;
  final String status;

  Volunteer({
    required this.id,
    required this.name,
    required this.content,
    required this.participantNo,
    required this.status,
  });

  factory Volunteer.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Volunteer(
      id: snapshot.id,
      name: data['name'],
      content: data['content'],
      participantNo: data['participantNo'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'content': content,
      'participantNo': participantNo,
      'status': status,
    };
  }
}
