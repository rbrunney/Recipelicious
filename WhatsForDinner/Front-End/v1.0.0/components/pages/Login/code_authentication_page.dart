import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import '../../util/requests.dart';
import '../../util/to_prev_page.dart';
import 'alert_pop_up.dart';
import '../../util/globals.dart' as globals;
import 'change_pass_page.dart';

class CodeAuthentication extends StatelessWidget {
  int generatedCode;
  String userEmail;
  Widget pageAfterAuthenticated;
  bool isDeleteCode;
  CodeAuthentication({
    Key? key,
    this.generatedCode = 0,
    this.userEmail = '',
    this.pageAfterAuthenticated = const Text('No Content'),
    this.isDeleteCode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController codeController = TextEditingController();
    Requests requests = Requests();

    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      const ToPrevPage(),
      const Center(
        heightFactor: 5,
        child: Text(
          "Enter Six-Digit Code",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: codeController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                labelText: 'Enter Code',
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.dialpad_outlined, color: Colors.grey)),
          )),
      Container(
          margin: const EdgeInsets.only(top: 25),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.tealAccent, // background
              ),
              onPressed: () {
                if (isDeleteCode) {
                  requests.makeDeleteRequest(
                      "http://10.0.2.2:8888/users/deleteUser/", {
                    "username": globals.username,
                    "password": globals.password
                  }).then((value) {
                    print(value);
                  });
                }

                if (generatedCode == int.parse(codeController.text)) {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: pageAfterAuthenticated,
                          type: PageTransitionType.bottomToTop));
                } else {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertPopUp(
                          title: 'Incorrect Code',
                          content:
                              'Please double check the email sent to your email-address',
                        );
                      });
                }
              },
              child:
                  const Text('Submit', style: TextStyle(color: Colors.black))))
    ])));
  }
}
