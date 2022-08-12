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
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
        ],
      ),
    );
  }
}
