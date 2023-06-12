import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String id;
  String email;
  String? name; //
  String? userIC; //선택적 매개변수로 변경
  String? place;
  double? latitude;
  double? longitude;
  String type;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.userIC,
    this.place,
    this.latitude,
    this.longitude,
    this.type = 'user',
  }); // 선택적 매개변수로 변경

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userIC': userIC,
      'place': place,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      userIC: map['userIC'],
      place: map['place'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      type: map['type'],
    );
  }
}
