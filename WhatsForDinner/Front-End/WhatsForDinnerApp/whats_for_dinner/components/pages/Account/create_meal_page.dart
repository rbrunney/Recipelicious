import 'package:flutter/material.dart';
import '../../util/to_prev_page.dart';
import 'Account_util/upload_image_icons.dart';
import '../../util/add_bar_bullet.dart';

class CreateMeal extends StatefulWidget {
  const CreateMeal({Key? key}) : super(key: key);

  @override
  State<CreateMeal> createState() => _CreateMealState();
}

class _CreateMealState extends State<CreateMeal> {
  TextEditingController nameOfMealController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController recipeController = TextEditingController();

  List<String> ingredients = [];

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
                    obscureText: true,
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
              const UploadImageIcons(),
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
            ],
          ),
        ),
      ),
    );
  }
}
