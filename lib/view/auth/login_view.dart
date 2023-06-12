import 'package:floodsafe/view/admin_homepage.dart';
import 'package:floodsafe/view/organizer_homepage.dart';
import 'package:floodsafe/view/register_view.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../viewmodel/auth_view_model.dart';
import 'homePage.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthViewModel _authViewModel = AuthViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Text('Sign In'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterView()),
                  );
                },
                child: Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      return;
    }

    UserModel? user =
        await _authViewModel.signInWithEmailAndPassword(email, password);
    if (user != null) {
      if (user.type == 'user') {
        // 일반 사용자는 HomePage로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(user: user),
          ),
        );
      } else if (user.type == 'organizer') {
        // Organizer는 OrganizerPage로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrganizerPage(user: user),
          ),
        );
      } else if (user.type == 'admin') {
        // Admin은 AdminPage로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminPage(user: user),
          ),
        );
      }
    } else {
      // 로그인 실패 처리
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid email or password'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Check'),
              ),
            ],
          );
        },
      );
    }
  }
}
