import 'package:floodsafe/view/loginPage.dart';
import 'package:floodsafe/view/signUpPage.dart';
import 'package:floodsafe/viewmodel/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppNavigator {
  static Future<bool> navigateToLoginPage(BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => UserViewModel(), child: loginPage()),
            fullscreenDialog: true));
  }

  static Future<bool> navigateToSignUpPage(BuildContext context) async {
    return await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => UserViewModel(), child: signUpPage()),
            fullscreenDialog: true));
  }
}
