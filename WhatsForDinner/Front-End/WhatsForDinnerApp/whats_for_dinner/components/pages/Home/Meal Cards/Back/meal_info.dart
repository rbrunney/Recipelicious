import 'package:flutter/material.dart';
import '../../../../util/to_prev_page.dart';
import 'ingredient_list.dart';
import 'recipe.dart';

class MealInfo extends StatelessWidget {
  String imgUrl;
  String mealName;
  String creator;
  String description;
  Map<String, dynamic> recipe;
  List<dynamic> ingredients;

  MealInfo({
    Key? key,
    this.imgUrl = "",
    this.mealName = "",
    this.creator = "",
    this.description = "",
    this.recipe = const {},
    this.ingredients = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
              child: Column(children: [
            const ToPrevPage(),
            Text(mealName,
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            Text("Creator: $creator",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  imgUrl,
                  width: 350,
                  height: 275,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IngredientList(
              ingredients: ingredients,
            ),
            Recipe(recipe: recipe)
          ])),
        ),
      ),
    );
  }
}
