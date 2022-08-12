import 'package:flutter/material.dart';
import 'ingredient_list.dart';
import 'recipe.dart';

class MealInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                    icon: const Icon(Icons.arrow_back_outlined),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Text(
                    'Name of Meal Here',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",
                        width: 350,
                        height: 275,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  IngredientList(ingredients: const ['Cat', 'Smiles', 'Memes', 'Have a Good Day!'],),
                  Recipe(recipe: const ["Get Cat", "Get Phone", "Play Memes", "Laugh At Memes", "Pet Cat", "Have Fun", "Have a great day!"],)
                ]
              )
            ),
        ),
      ),
    );
  }
}
