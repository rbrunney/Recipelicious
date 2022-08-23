import 'package:flutter/material.dart';
import '../../../util/to_prev_page.dart';

class EditInfoPagePassword extends StatelessWidget {
  const EditInfoPagePassword({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController =
        TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ToPrevPage(),
              Column(
                children: [
                  const Center(
                    heightFactor: 5,
                    child: Text(
                      "Edit password",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: TextField(
                        obscureText: true,
                        controller: oldPasswordController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Old password')),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      obscureText: true,
                      controller: newPasswordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'New password'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: TextField(
                      obscureText: true,
                      controller: confirmNewPasswordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirm password'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (oldPasswordController.text != "poopyhead") {
                          await showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    const Text('Old password was not correct'),
                                content: const Text(
                                    'Your old password did not match'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (newPasswordController.text !=
                            confirmNewPasswordController.text) {
                          await showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('New password did not match'),
                                content: const Text(
                                    'Your new password did not matched with the confirm password'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          await showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Password has been Edited'),
                                content: const Text(
                                    'Your password has been changed'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        oldPasswordController.clear();
                        newPasswordController.clear();
                        confirmNewPasswordController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.tealAccent, // background
                        ),
                        child: const Text(
                          'Edit Password',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
