import 'package:flutter/material.dart';
import 'create_ingredient_page.dart';
import '../Account/Account_util/add_floating_button.dart';
import 'ingredient_card.dart';
import '../../util/requests.dart';
import '../../util/globals.dart' as globals;
import 'dart:convert';

class PantryPage extends StatefulWidget {
  const PantryPage({Key? key}) : super(key: key);

  @override
  State<PantryPage> createState() => _CreatePantryState();
}

class _CreatePantryState extends State<PantryPage> {
  Requests requests = Requests();
  List<Map<String, dynamic>> ingredients = [];

  @override
  Widget build(BuildContext context) {
    Future<String>? futurePantryInfo = requests
        .makeGetRequest("http://10.0.2.2:8888/fridge/${globals.fridgeID}");

    return SafeArea(
      child: Scaffold(
        floatingActionButton: const AddFloatingButton(
          widgetPage: CreateIngredientPage(),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 30),
              child: const Text(
                'Ingredients',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ingredients.length,
                  itemBuilder: (context, index) {
                    final String ingredientName = ingredients[index]['name'];
                    int ingredientQty = ingredients[index]['qty'];
                    final String ingredientType = ingredients[index]['type'];

                    return Dismissible(
                      key: Key(ingredientName),
                      onDismissed: (direction) {
                        ingredients.removeAt(index);
                      },
                      child: IngredientCard(
                        ingredientName: ingredientName,
                        ingredientQty: ingredientQty,
                        ingredientType: ingredientType,
                      ),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
