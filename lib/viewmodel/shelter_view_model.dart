import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floodsafe/model/shelter.dart';
import 'package:flutter/material.dart';

class ShelterViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Shelter> _shelters = [];
  List<Shelter> get shelters => _shelters;

  Future<void> fetchShelters() async {
    final snapshot = await _firestore.collection('shelters').get();
    _shelters = snapshot.docs.map((doc) => Shelter.fromSnapshot(doc)).toList();
    notifyListeners();
  }
}
