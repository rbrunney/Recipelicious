import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../util/page_navigation.dart';
import '../../util/requests.dart';
import 'alert_pop_up.dart';
import 'create_account.dart';
import 'forgot_password_page.dart';
import 'dart:convert';
import '../../util/globals.dart' as globals;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    Requests requests = Requests();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Center(
              heightFactor: 5,
              child: Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_outlined,
                          color: Colors.grey),
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
                  controller: _passwordController,
                  obscureText: true,
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
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: 15,
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.center,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: const ForgotPasswordPage(),
                                      ));
                                },
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.tealAccent,
                                      decoration: TextDecoration.underline),
                                ))))
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(top: 25, bottom: 25),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.tealAccent, // background
                            ),
                            onPressed: () {
                              if (_usernameController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
                                showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertPopUp(
                                        title: 'Login Fields Empty',
                                        content:
                                            'Login Form is not filled out completly',
                                      );
                                    });
                              } else {
                                requests
                                    .makeGetRequest(
                                        "http://10.0.2.2:8888/users/passwordCheck/${_usernameController.text}/${_passwordController.text}")
                                    .then((value) {
                                  try {
                                    print(value);
                                    if (json.decode(value)["result"]) {
                                      globals.userID =
                                          json.decode(value)["userID"];
                                      globals.username =
                                          _usernameController.text;
                                      globals.password =
                                          _passwordController.text;
                                      globals.isLoggedIn = true;
                                      requests
                                          .makeGetRequestWithAuth(
                                              "http://10.0.2.2:8888/fridge/getByUsername/${globals.username}",
                                              globals.username,
                                              globals.password)
                                          .then((value) {
                                        print(json.decode(value));
                                        globals.fridgeID =
                                            json.decode(value)["result"]
                                                ["FridgeID"];
                                        print(globals.fridgeID);
                                      });

                                      requests
                                          .makeGetRequest(
                                              "http://10.0.2.2:8888/users/getUser/${globals.userID}")
                                          .then((value) {
                                        globals.name =
                                            json.decode(value)["name"];
                                        globals.email =
                                            json.decode(value)["email"];
                                        globals.birthday =
                                            json.decode(value)["birthday"];
                                      });

                                      Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            child: const PageNavigation(),
                                          ));
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                    } else {
                                      showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertPopUp(
                                              title: 'Login Failed',
                                              content:
                                                  'Login Information was incorrect try again',
                                            );
                                          });
                                    }
                                  } catch (e) {
                                    showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertPopUp(
                                            title: 'Login Failed',
                                            content:
                                                'Login Information was incorrect try again',
                                          );
                                        });
                                  }
                                });
                              }
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.tealAccent, // background
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: const CreateAccount(),
                                      ));
                                },
                                child: const Text('Sign Up',
                                    style: TextStyle(color: Colors.black)))))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
