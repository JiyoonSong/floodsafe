import 'package:flutter/material.dart';

import '../../model/user.dart';
import '../../viewmodel/auth_view_model.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AuthViewModel _authViewModel = AuthViewModel();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedType = 'user';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              DropdownButton<String>(
                value: _selectedType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue!;
                  });
                },
                items: <String>['user', 'organizer']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _createUserWithEmailAndPassword();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey, // 회색 배경색으로 변경
                ),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createUserWithEmailAndPassword() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    UserModel? user = await _authViewModel.createUserWithEmailAndPassword(
      email,
      password,
      type: _selectedType,
    );
//UserModel? user = await _authViewModel.createUserWithEmailAndPassword(email, password, "", "");
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginView()), // 로그인 페이지로 이동
      );
      // 회원가입 성공 처리
    } else {
      // 회원가입 실패 처리
    }
  }
}
