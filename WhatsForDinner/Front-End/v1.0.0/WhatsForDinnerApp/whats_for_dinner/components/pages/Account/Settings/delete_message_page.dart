import 'package:flutter/material.dart';
import '../../Login/login_page.dart';

class DeleteMessagePage extends StatelessWidget {
  const DeleteMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                heightFactor: 5,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 250),
                      alignment: Alignment.center,
                      child: const Text('Thanks for being a memeber!',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Hope to see you again!',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 25),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.tealAccent, // background
                            ),
                            child: const Text(
                              'To Login Page',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (Route<dynamic> route) => false);
                            })),
                  ],
                ))));
  }
}
