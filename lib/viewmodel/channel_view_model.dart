import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:floodsafe/model/post.dart';
import 'package:floodsafe/model/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChannelViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final UserModel _user;

  ChannelViewModel({required UserModel user}) : _user = user;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Stream<List<Post>> get postsStream =>
      _firestore.collection('posts').snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      });

  Future<void> fetchPosts() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('posts').get();
      _posts = snapshot.docs
          .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
          .where((post) => post.userId != _user.id) // 사용자의 글 제외
          .toList();
      notifyListeners();
    } catch (e) {
      // 에러 처리
    }
  }

  Future<void> addPost(Post post, PickedFile image) async {
    try {
      final Reference storageRef = _firebaseStorage
          .ref()
          .child('post_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      final File imageFile = File(image.path);
      if (!imageFile.existsSync()) {
        throw Exception('Image file not found');
      }

      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      final String imageUrl = await snapshot.ref.getDownloadURL();

      post.imageUrl = imageUrl ?? '';
      post.date = DateTime.now();
      post.name = _user.name; // Add user name
      post.place = _user.place;
      post.latitude = _user.latitude;
      post.longitude = _user.longitude;

      final DocumentReference docRef =
          await _firestore.collection('posts').add(post.toMap());
      post.id = docRef.id; // Assign the generated ID to the post

      await _firestore
          .collection('posts')
          .doc(post.id)
          .update({'id': post.id}); // Update the post with the assigned ID

      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error adding post: $e');
    }
  }

  Future<void> deletePost(Post post) async {
    try {
      await _firestore.collection('posts').doc(post.id).delete();
      fetchPosts();
    } catch (e) {
      // 에러 처리
    }
  }

  Future<void> reportPost(Post post) async {
    try {
      await _firestore
          .collection('posts')
          .doc(post.id)
          .update({'postStatus': 'reported'});
    } catch (e) {
      throw Exception('Error reporting post: $e');
    }
  }

  List<Post> _inactivePosts = [];
  List<Post> get inactivePosts => _inactivePosts;

  Future<void> _getInactivePosts() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('posts')
          .where('postStatus', isEqualTo: 'inactive')
          .get();
      _inactivePosts = snapshot.docs
          .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners();
    } catch (e) {
      // 에러 처리
    }
  }

  Future<void> _deletePost(Post post) async {
    try {
      await _firestore.collection('posts').doc(post.id).delete();
      await fetchPosts();
    } catch (e) {
      // 에러 처리
    }
  }
}
