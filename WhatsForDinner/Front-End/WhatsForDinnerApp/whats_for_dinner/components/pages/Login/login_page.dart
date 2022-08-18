import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../util/page_navigation.dart';
import '../Home/home_page.dart';
import 'create_account.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

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
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      border: OutlineInputBorder(),
                      hintText: 'Enter Username...',
                      labelText: 'Enter Username'),
                )),
            Container(
                margin: const EdgeInsets.only(top: 35, left: 15, right: 15),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline),
                      hintText: 'Enter Password...',
                      labelText: 'Enter Password'),
                )),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
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
                                      decoration: TextDecoration.underline),
                                ))))
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(top: 35, bottom: 35),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            onPressed: () {
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
                              print(
                                  '${_usernameController.text} ${_passwordController.text}');
                            },
                            child: const Text('Log In')),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.bottomToTop,
                                        child: const CreateAccount(),
                                      ));
                                },
                                child: const Text('Sign Up'))))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
