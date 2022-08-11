import 'package:flutter/material.dart';
import 'account_header.dart';
import 'your_meals_switch.dart';

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
          child: const Icon(Icons.settings_outlined, size: 25),
        ),
        const AccountHeader(),
        const YourMealsSwitch(),
      ]),
    );
  }
}
