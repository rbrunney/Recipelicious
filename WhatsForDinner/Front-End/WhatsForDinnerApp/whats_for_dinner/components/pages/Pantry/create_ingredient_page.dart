import 'package:flutter/material.dart';
import '../../util/to_prev_page.dart';
import 'dropdown_menu.dart';

class CreateIngredientPage extends StatefulWidget {
  const CreateIngredientPage({Key? key}) : super(key: key);

  @override
  State<CreateIngredientPage> createState() => _CreateIngredientState();
}

class _CreateIngredientState extends State<CreateIngredientPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameOfIngredientController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            const ToPrevPage(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Create Ingredient',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                "Name",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextField(
                  controller: nameOfIngredientController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Ingredient name...",
                      labelText: 'Enter Ingredient name')),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                'Quantity',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Qty...",
                      labelText: 'Qty')),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                'Measurement',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 80,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: const DropdownMenu(),
            ),
            Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.tealAccent, // background
                      ),
                      child: const Text(
                        'Create Ingredient',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
          ]),
        ),
      ),
    );
  }
}
