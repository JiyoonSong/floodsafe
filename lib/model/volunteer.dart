import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Volunteer {
  final String id;
  final String name;
  final String content;
  final int participantNo;
  late final String status;
  String? userStatus;

  Volunteer({
    required this.id,
    required this.name,
    required this.content,
    required this.participantNo,
    required this.status,
    this.userStatus,
  });

  factory Volunteer.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Volunteer(
      id: snapshot.id,
      name: data['name'],
      content: data['content'],
      participantNo: data['participantNo'],
      status: data['status'],
      userStatus: data['userStatus'],
    );
  }
}
