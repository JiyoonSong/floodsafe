import 'package:floodsafe/viewmodel/UserViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class loginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late UserViewModel _loginVM;

  void _login(BuildContext context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    bool islogin = await _loginVM.login(email, password);
    if (islogin) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    _loginVM = Provider.of<UserViewModel>(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future<bool>.value(false);
      },
      child: Scaffold(
          appBar: AppBar(title: Text("Login"), backgroundColor: Colors.grey),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Email"),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(hintText: "Password"),
                      ),
                      TextButton(
                        child: Text("Login",
                            style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          _login(context);
                        },
                      ),
                      Text(_loginVM.message)
                    ],
                  )),
            ),
          )),
    );
  }
}
