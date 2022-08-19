import 'package:flutter/material.dart';
import '../../util/to_prev_page.dart';
import 'login_page.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: const TextField(
                decoration: InputDecoration(
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
              child: const TextField(
                decoration: InputDecoration(
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
              child: const TextField(
                decoration: InputDecoration(
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
              child: const TextField(
                decoration: InputDecoration(
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
              child: const TextField(
                decoration: InputDecoration(
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
              child: const TextField(
                decoration: InputDecoration(
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
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Text('Sign Up',
                      style: TextStyle(color: Colors.black))))
        ]),
      ))
    ])));
  }
}
