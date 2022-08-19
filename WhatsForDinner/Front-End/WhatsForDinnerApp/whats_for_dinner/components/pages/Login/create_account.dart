import 'package:flutter/material.dart';
import '../../util/requests.dart';
import '../../util/to_prev_page.dart';
import 'alert_pop_up.dart';
import 'login_page.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _birthdayController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      const ToPrevPage(),
      const Center(
        heightFactor: 3,
        child: Text(
          "Create Account",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
          child: SingleChildScrollView(
        child: Column(children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.account_circle_outlined, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter Name...',
                    labelText: 'Enter Name',
                    labelStyle: TextStyle(color: Colors.grey)),
              )),
          Container(
              margin: const EdgeInsets.only(top: 35, left: 15, right: 15),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.account_circle_outlined, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter Username...',
                    labelText: 'Enter Username',
                    labelStyle: TextStyle(color: Colors.grey)),
              )),
          Container(
              margin: const EdgeInsets.only(top: 35, left: 15, right: 15),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'Enter Email...',
                    labelText: 'Enter Email',
                    labelStyle: TextStyle(color: Colors.grey)),
              )),
          Container(
              margin: const EdgeInsets.only(top: 35, left: 15, right: 15),
              child: TextField(
                controller: _birthdayController,
                decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.calendar_today_outlined, color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: 'mm/dd/yyyy...',
                    labelText: 'Enter Birthday (mm/dd/yyyy)',
                    labelStyle: TextStyle(color: Colors.grey)),
              )),
          Container(
              margin: const EdgeInsets.only(top: 35, left: 15, right: 15),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                    hintText: 'Enter Password...',
                    labelText: 'Enter Password',
                    labelStyle: TextStyle(color: Colors.grey)),
              )),
          Container(
              margin: const EdgeInsets.only(top: 35, left: 15, right: 15),
              child: TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                    hintText: 'Confirm Password...',
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.grey)),
              )),
          Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.tealAccent, // background
                  ),
                  onPressed: () {
                    // Checking to see if form is complete
                    if (_nameController.text.isEmpty ||
                        _usernameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _birthdayController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty) {
                      showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertPopUp(
                              title: 'Incomplete Form',
                              content:
                                  'Please check all fields have been filled out correctly',
                            );
                          });
                    } else {
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertPopUp(
                                title: 'Passwords Do Not Match',
                                content:
                                    'Please check that password and confirm password match',
                              );
                            });
                      } else {
                        Map<String, dynamic> newUser = {
                          "name": _nameController.text,
                          "username": _usernameController.text,
                          "password": _passwordController.text,
                          "email": _emailController.text,
                          "birthday": _birthdayController.text
                        };
                        Requests().makePostRequest(
                            "http://10.0.2.2:8000/createUser/", newUser);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false);
                      }
                    }
                  },
                  child: const Text('Sign Up',
                      style: TextStyle(color: Colors.black))))
        ]),
      ))
    ])));
  }
}
