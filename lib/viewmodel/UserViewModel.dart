// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserViewModel extends ChangeNotifier {
  String message = "";

  Future<bool> register(String email, String password) async {
    bool isRegistered = false;

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      isRegistered = userCredential != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        message = "Password is weak";
      } else if (e.code == "email-already-in-use") {
        message = "Email already in use";
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }

    return isRegistered;
  }

  Future<bool> login(String email, String password) async {
    bool isLogin = false;

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLogin = userCredential != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        message = "User is not registered";
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return isLogin;
  }
}
