import 'package:flutter/material.dart';

class YourMealsSwitch extends StatefulWidget {
  const YourMealsSwitch({Key? key}) : super(key: key);

  @override
  _YourMealsSwitch createState() => _YourMealsSwitch();
}

class _YourMealsSwitch extends State<YourMealsSwitch> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
