import 'package:flutter/material.dart';
import '../../util/to_prev_page.dart';
import '../Home/Meal Cards/Back/ingredient_list.dart';
import '../Home/Meal Cards/Back/recipe.dart';
import '../../util/globals.dart' as globals;

class ChatMealInfo extends StatelessWidget {
  final String imgUrl;
  final String mealName;
  final String creator;
  final String description;
  final Map<String, dynamic> recipe;
  final List<dynamic> ingredients;

  const ChatMealInfo({
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
            Recipe(recipe: recipe),
            ElevatedButton(
              onPressed: () {
                globals.mealID = globals.mealID;
              },
              child: const Text('Send Meal'),
            )
          ])),
        ),
      ),
    );
  }
}
