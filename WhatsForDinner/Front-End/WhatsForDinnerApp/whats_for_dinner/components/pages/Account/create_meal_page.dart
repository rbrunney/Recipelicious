import 'package:flutter/material.dart';
import '../../util/to_prev_page.dart';
import 'Account_util/upload_image_icons.dart';
import '../../util/add_bar_bullet.dart';
import '../../util/add_bar_ordered.dart';

class CreateMeal extends StatefulWidget {
  const CreateMeal({Key? key}) : super(key: key);

  @override
  State<CreateMeal> createState() => _CreateMealState();
}

class _CreateMealState extends State<CreateMeal> {
  TextEditingController nameOfMealController = TextEditingController();

  List<dynamic> ingredients = [];
  Map<String, dynamic> recipe = {};

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const ToPrevPage(),
              const Text(
                'Create Meal',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: TextField(
                    controller: nameOfMealController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Meal Name...",
                        labelText: 'Enter Meal Name')),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              UploadImageIcons(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              AddBarBullet(
                hintText: "Enter Ingredient...",
                labelText: "Enter Ingredient",
                information: ingredients,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Recipe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              AddBarOrdered(
                hintText: "Enter Recipe...",
                labelText: "Enter Recipe",
                information: recipe,
              ),
              
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: ElevatedButton(
                    onPressed: () {
                      if (nameOfMealController.text != '' &&
                          ingredients.isNotEmpty &&
                          recipe.isNotEmpty) {
                        Navigator.of(context).pop();
                        print('Call Davids Api');
                      } else {
                        null;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.tealAccent, // background
                    ),
                    child: const Text(
                      'Create Meal',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
