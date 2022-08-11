import 'package:flutter/material.dart';

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
        Container(
          margin: const EdgeInsets.only(top: 25, left: 5, right: 5),
          child: Row(children: [
            Container(
              child: const Expanded(
                flex: 1,
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 85,
                ),
              ),
            ),
            Container(
              child: Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          'Hello,',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          'ROBERT BRUNNEY',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
        Container(
          child: Row(
            children: [
              Container(
                child: const Expanded(
                  flex: 2,
                  child: Text('Your Meals'),
                ),
              ),
              Container(
                child: Expanded(
                  child: Switch(
                    value: isSwitched,
                    onChanged: ((value) {
                      setState(() {
                        isSwitched = value;
                      });
                    }),
                    activeTrackColor: Colors.grey,
                    activeColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
