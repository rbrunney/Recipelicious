import 'package:flutter/material.dart';
import '../../../util/requests.dart';
import '../../Login/login_page.dart';
import 'account_edit_info.dart';
import '../../../util/to_prev_page.dart';
import '../../../util/globals.dart' as globals;
import '../../Login/code_authentication_page.dart';
import 'dart:math';
import 'package:page_transition/page_transition.dart';

import 'delete_message_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  Requests requests = Requests();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const ToPrevPage(),
            const Text(
              "Settings",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: const Text(
                "Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                const Text(
                  "Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                AccountEditInfo(
                    accountInfo: globals.name, editProfileInfo: "Name"),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 13),
                  child: const Text(
                    "Email",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                AccountEditInfo(
                    accountInfo: globals.email, editProfileInfo: "Email"),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 13),
                  child: const Text(
                    "Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const AccountEditInfo(
                    accountInfo: "***********", editProfileInfo: "Password"),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 13),
                  child: const Text(
                    "Birthday",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                AccountEditInfo(
                    accountInfo: globals.birthday, editProfileInfo: "Birthday"),
                Container(
                  margin: const EdgeInsets.only(top: 60, bottom: 5),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.tealAccent, // background
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false);
                      }),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.tealAccent, // background
                      ),
                      child: const Text(
                        'Delete Account',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      onPressed: () {
                        Random random = Random();
                        int authenticationCode =
                            random.nextInt(900000) + 100000;
                        requests.makePostRequest(
                            "http://10.0.2.2:8888/users/forgotPassword/", {
                          "email": globals.email,
                          "authCode": authenticationCode
                        }).then((value) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: CodeAuthentication(
                                    generatedCode: authenticationCode,
                                    userEmail: globals.email,
                                    isDeleteCode: true,
                                    pageAfterAuthenticated:
                                        const DeleteMessagePage(),
                                  ),
                                  type: PageTransitionType.bottomToTop));
                        });
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
