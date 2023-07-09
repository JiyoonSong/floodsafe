import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostPopup extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String? place;
  final DateTime date;
  final String? name;

  PostPopup({
    required this.imageUrl,
    required this.description,
    this.place,
    required this.date,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 300,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 수평 방향 왼쪽 정렬
          children: [
            Image.network(imageUrl),
            SizedBox(height: 16),
            Text(
              'Description: $description',
              textAlign: TextAlign.left, // 왼쪽 정렬
            ),
            SizedBox(height: 8),
            Text(
              'Place: ${place ?? "Unknown"}',
              textAlign: TextAlign.left, // 왼쪽 정렬
            ),
            SizedBox(height: 8),
            Text(
              'Date: ${DateFormat('yyyy-MM-dd HH:mm').format(date)}',
              textAlign: TextAlign.left, // 왼쪽 정렬
            ),
            SizedBox(height: 8),
            Text(
              'User Name: ${name ?? "Unknown"}',
              textAlign: TextAlign.left, // 왼쪽 정렬
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
