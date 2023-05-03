import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class PostViewModel extends ChangeNotifier {
  Future<String> uploadFile(File file) async {
    late String downloadURL;

    final uuid = Uuid();
    final filePath = "/images/${uuid.v4()}.jpg";
    final storage = FirebaseStorage.instance.ref(filePath);
    final uploadTask = await storage.putFile(file);

    if (uploadTask.state == TaskState.success) {
      downloadURL =
          await FirebaseStorage.instance.ref(filePath).getDownloadURL();
    }
    return downloadURL;
  }
}
