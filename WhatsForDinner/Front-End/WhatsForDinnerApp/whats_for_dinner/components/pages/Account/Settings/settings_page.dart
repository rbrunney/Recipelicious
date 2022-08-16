import 'package:flutter/material.dart';
import '../Edit_pages/edit_info_page.dart';
import 'package:page_transition/page_transition.dart';

import 'account_edit_info.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
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
              children: const [
                Text(
                  "Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                AccountEditInfo(
                    accountInfo: "Robert Brunney", editProfileInfo: "Name"),
              ],
            ),
            Column(
              children: const [
                Text(
                  "Email",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                AccountEditInfo(
                    accountInfo: "Rbrunney@student.neumont.edu",
                    editProfileInfo: "Email"),
              ],
            ),
            Column(
              children: const [
                Text(
                  "Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                AccountEditInfo(
                    accountInfo: "***********", editProfileInfo: "Password"),
              ],
            ),
            Column(
              children: const [
                Text(
                  "Birthday",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                AccountEditInfo(
                    accountInfo: "10/1/2001", editProfileInfo: "Birthday"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
