import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String content;
  String? place;
  double? latitude;
  double? longitude;
  String? userId;
  String imageUrl;
  DateTime date;
  String? postStatus;
  String? name;

  Post({
    this.id,
    required this.content,
    required this.place,
    required this.latitude,
    required this.longitude,
    required this.userId,
    required this.imageUrl,
    required this.date,
    required this.postStatus,
    required this.name,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      content: map['content'],
      place: map['place'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      userId: map['userId'],
      imageUrl: map['imageUrl'],
      date: map['date'] != null
          ? (map['date'] as Timestamp).toDate()
          : DateTime.now(),
      postStatus: map['postStatus'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'place': place,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'imageUrl': imageUrl,
      'date': date,
      'postStatus': postStatus,
      'name': name,
    };
  }
}
