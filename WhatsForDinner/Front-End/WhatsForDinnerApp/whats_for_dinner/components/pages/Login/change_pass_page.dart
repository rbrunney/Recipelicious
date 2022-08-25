import 'package:flutter/material.dart';
import '../../util/requests.dart';
import '../../util/to_prev_page.dart';
import 'alert_pop_up.dart';
import 'login_page.dart';

class ChangePassPage extends StatelessWidget {
  String userEmail;
  ChangePassPage({Key? key, this.userEmail = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController newPassController = TextEditingController();
    TextEditingController confirmNewPassController = TextEditingController();
    Requests requests = Requests();

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
          child: TextField(
            controller: newPassController,
            decoration: const InputDecoration(
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
          child: TextField(
            controller: confirmNewPassController,
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
          margin: const EdgeInsets.only(top: 25),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.tealAccent, // background
              ),
              onPressed: () {
                if (newPassController.text.isEmpty ||
                    confirmNewPassController.text.isEmpty) {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertPopUp(
                          title: 'Empty Fields',
                          content:
                              'Please double check all text fields have been filled out',
                        );
                      });
                } else if (newPassController.text !=
                    confirmNewPassController.text) {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertPopUp(
                          title: 'Mis-Matched Password',
                          content:
                              'Please double check your ew password and confirm password match!',
                        );
                      });
                } else {

                  // Make request here one to get user information
                  // And then make one from there
                  

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (Route<dynamic> route) => false);
                }
              },
              child:
                  const Text('Submit', style: TextStyle(color: Colors.black))))
    ])));
  }
}
