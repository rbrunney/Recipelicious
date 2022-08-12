import 'package:flutter/material.dart';

import 'Meal Cards/Front/meal_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Make request to get list of meals

  @override
  Widget build(BuildContext build) {

    return SingleChildScrollView(
      child: Column(
        children: const [
          // Text('Home Page'),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
          MealCard(),
        ],
      ),
    );
  }
}
