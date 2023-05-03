import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../viewmodel/UserViewModel.dart';

class signUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late UserViewModel _registerVM;

  Future<bool> _registerUser(BuildContext context) async {
    bool isRegistered = false;

    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      isRegistered = await _registerVM.register(email, password);
      if (isRegistered) {
        Navigator.pop(context, true);
      }
    }

    return isRegistered;
  }

  @override
  Widget build(BuildContext context) {
    _registerVM = Provider.of<UserViewModel>(context);

    return Scaffold(
        appBar:
            AppBar(title: const Text("Register"), backgroundColor: Colors.grey),
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
                        return "Email is required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                  TextButton(
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        _registerUser(context);
                      }),
                  Text(_registerVM.message)
                ],
              ),
            ),
          ),
        ));
  }
}
