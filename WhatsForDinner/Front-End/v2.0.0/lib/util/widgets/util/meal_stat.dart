import 'package:flutter/material.dart';

import '../../style/style.dart';
import '../text/custom_text.dart';

class MealStat extends StatelessWidget {
  final IconData icon;
  final String stat;
  const MealStat({
    super.key,
    required this.icon,
    required this.stat
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.01
          ),
          child: Icon(
              icon,
              size: 28,
              color: Color(CustomColorPalette.primaryColor)
          ),
        ),
        CustomText(
          text: ' $stat',
          fontSize: 18,
          color: Color(CustomColorPalette.textBodyColor),
        )
      ],
    );
  }
}
