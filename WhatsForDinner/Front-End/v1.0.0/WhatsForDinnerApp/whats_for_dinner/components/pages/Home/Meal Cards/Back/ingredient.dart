import 'package:flutter/material.dart';

import 'bullet_point.dart';

class Ingredient extends StatelessWidget {
  Ingredient(
      {Key? key,
      this.ingredientName = '',
      this.quantity = 0,
      this.measurement = ''})
      : super(key: key);

  String ingredientName;
  int quantity;
  String measurement;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          left: 25,
        ),
        child: Row(children: [
          const BulletPoint(),
          Container(
              margin: const EdgeInsets.only(left: 25, top: 5, bottom: 5),
              child: Row(
                children: [
                  Text(ingredientName,
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 20),
                      )),
                  Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        measurement,
                        style: const TextStyle(fontSize: 20),
                      ))
                ],
              ))
        ]));
  }
}
