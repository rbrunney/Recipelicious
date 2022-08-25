import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../util/to_prev_page.dart';
import 'code_authentication_page.dart';
import 'dart:math';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    TextEditingController usersEmail = TextEditingController();

    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        const ToPrevPage(),
        const Center(
          heightFactor: 5,
          child: Text(
            "Forgot Password",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
                controller: usersEmail,
                decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: 'Enter Email',
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.email, color: Colors.grey)),
        )),
        Container(
          margin: const EdgeInsets.only(top: 25),
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.tealAccent, // background
                ),
                onPressed: () {
                  Random random = new Random();
                  Navigator.push(context,
                    PageTransition(child: CodeAuthentication(generatedCode: random.nextInt(900000) + 100000), type: PageTransitionType.bottomToTop));
                },
                child: const Text('Submit', style: TextStyle(color: Colors.black))))
      ],
    )));
  }
}
