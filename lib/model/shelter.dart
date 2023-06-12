import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Shelter {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final DateTime updateDate;

  Shelter({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.updateDate,
  });

  factory Shelter.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Shelter(
      id: snapshot.id,
      name: data['name'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      updateDate: (data['updateDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'updateDate': updateDate,
    };
  }
}
