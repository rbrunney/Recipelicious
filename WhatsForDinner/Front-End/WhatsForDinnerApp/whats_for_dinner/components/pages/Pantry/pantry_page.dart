import 'package:flutter/material.dart';
import 'create_ingredient_page.dart';
import '../Account/Account_util/add_floating_button.dart';
import 'ingredient_card.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({Key? key}) : super(key: key);

  @override
  State<PantryPage> createState() => _CreatePantryState();
}

class _CreatePantryState extends State<PantryPage> {
  List<Map<String, dynamic>> ingredients = [
    {'name': 'Chocolate', 'qty': 2, 'type': 'oz'},
    {'name': 'Tomato', 'qty': 7, 'type': 'lbs'},
    {'name': 'your mom', 'qty': 1, 'type': 'lbs'},
  ];

  @override
  Widget build(BuildContext context) {
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
                      onDismissed: (direction){
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
