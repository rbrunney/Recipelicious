import 'package:flutter/material.dart';

import 'ingredient.dart';

class IngredientList extends StatelessWidget {
  List<dynamic> ingredients;
  IngredientList({Key? key, this.ingredients = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> ingredientList = [
      const Text('Ingredients',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
    ];

    // Making a widget for every ingredient passed through
    ingredients.forEach((ingredient) {
      print(ingredient);
      ingredientList.add(Ingredient(
        ingredientName: ingredient['name'],
        quantity: ingredient['qty'],
        // measurement: ingredient['measurement'],
      ));
    });

    return Container(
        margin: const EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: Column(
          children: ingredientList,
        ));
  }
}
