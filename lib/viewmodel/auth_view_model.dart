import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class AuthViewModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> createUserWithEmailAndPassword(
      String email, String password,
      {String? name, String? place, String type = 'user'}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        UserModel userModel = UserModel(
            id: user.uid,
            email: user.email!,
            name: name,
            place: place,
            type: type);
        await _firestore
            .collection('users')
            .doc(user.uid)
            .set(userModel.toMap());
        print('Registration successful');
        return userModel;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> updateUserProfile(UserModel updatedUser) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(updatedUser.id)
          .update(updatedUser.toMap());

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        UserModel userModel = UserModel.fromMap(userSnapshot.data()!);
        return userModel;
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await _firestore.collection('users').doc(user.uid).get();
        if (userSnapshot.exists) {
          UserModel userModel = UserModel.fromMap(userSnapshot.data()!);
          return userModel;
        }
      }
      return null;
    } catch (e) {
      print(e.toString());
      print('Incorrect email or password');
      return null;
    }
  }
}
