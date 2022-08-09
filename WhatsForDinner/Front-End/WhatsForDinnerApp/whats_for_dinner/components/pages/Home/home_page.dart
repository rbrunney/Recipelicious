import 'package:flutter/material.dart';

import '../meal_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext build) {

    return SingleChildScrollView(
      child: Column(
        children: const [
          Text('Home Page'),
          MealCard()
        ],
      ),
    );
  }
}
