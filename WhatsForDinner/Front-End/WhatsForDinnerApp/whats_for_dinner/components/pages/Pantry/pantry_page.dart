import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'create_ingredient_page.dart';
import '../Account/Account_util/add_floating_button.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({Key? key}) : super(key: key);

  @override
  State<PantryPage> createState() => _CreatePantryState();
}

class _CreatePantryState extends State<PantryPage> {
  List<Map<String, dynamic>> ingredients = [
    {'name': 'Chocolate', 'qty': 2, 'type': 'oz'},
    {'name': 'Tomato', 'qty': 7, 'type': 'lbs'}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: const AddFloatingButton(widgetPage: CreateIngredientPage(),),
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
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(left: 12),
                                child: Text(
                                  ingredientName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Container(
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(
                                          left: 50, right: 5),
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              ingredients[index]['qty']--;
                                            });
                                          },
                                          icon: const Icon(
                                              FontAwesomeIcons.minus))),
                                  Text(
                                    "$ingredientQty ($ingredientType)",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(left: 5),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          ingredients[index]['qty']++;
                                        });
                                      },
                                      icon: const Icon(FontAwesomeIcons.plus),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
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
