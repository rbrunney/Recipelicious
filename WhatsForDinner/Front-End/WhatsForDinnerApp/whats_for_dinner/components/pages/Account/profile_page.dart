import 'package:flutter/material.dart';
import 'Account_util/account_header.dart';
import 'Account_util/meal_tab_bar.dart';
import 'Settings/settings_page.dart';
import 'package:page_transition/page_transition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(right: 15, top: 15),
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.settings_outlined, size: 25),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const SettingsPage()),
              );
            },
          ),
        ),
        const AccountHeader(),
        const MealAppBar(),
      ]),
    );
  }
}
