import 'package:flutter/material.dart';
import '../../util/to_prev_page.dart';
import 'login_page.dart';

class ChangePassPage extends StatelessWidget {
  const ChangePassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      const ToPrevPage(),
      const Center(
        heightFactor: 5,
        child: Text(
          "New Password",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: const TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: 'Enter New Password...',
                labelText: 'Enter New Password',
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
          margin: const EdgeInsets.only(top: 25),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.tealAccent, // background
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (Route<dynamic> route) => false);
              },
              child:
                  const Text('Submit', style: TextStyle(color: Colors.black))))
    ])));
  }
}
