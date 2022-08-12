import 'package:flutter/material.dart';

import 'ingredient.dart';

class IngredientList extends StatelessWidget {
  List<String> ingredients;
  IngredientList({Key? key, this.ingredients = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> ingredientList = [
      const Text('Ingredients',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
    ];

    // Making a widget for every ingredient passed through
    ingredients.forEach((ingredient) => ingredientList.add(Ingredient(
          ingredientName: ingredient,
    )));

    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: Column(
        children: ingredientList,
      )
    );
  }
}
