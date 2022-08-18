import 'package:flutter/material.dart';
import 'account_edit_info.dart';
import '../../../util/to_prev_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
              children: const [
                Text(
                  "Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                AccountEditInfo(
                    accountInfo: "Robert", editProfileInfo: "Name"),
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
                const AccountEditInfo(
                    accountInfo: "Rbrunney@student.neumont.edu",
                    editProfileInfo: "Email"),
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
                const AccountEditInfo(
                    accountInfo: "10/1/2001", editProfileInfo: "Birthday"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
