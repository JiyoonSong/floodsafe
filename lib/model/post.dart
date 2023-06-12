import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String content;
  String? place;
  String? userId;
  String imageUrl;
  DateTime date;
  String? postStatus;
  String? name; // Add username attribute

  Post({
    this.id = '',
    required this.content,
    required this.place,
    required this.userId,
    required this.imageUrl,
    required this.date,
    required this.postStatus,
    required this.name, // Initialize username
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      place: map['place'],
      userId: map['userId'],
      imageUrl: map['imageUrl'] ?? '',
      date: map['date'] != null
          ? (map['date'] as Timestamp).toDate()
          : DateTime.now(),
      name: map['name'] ?? '',
      postStatus: map['postStatus'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'place': place,
      'userId': userId,
      'imageUrl': imageUrl,
      'date': date,
      'name': name,
      'postStatus': postStatus,
    };
  }
}
