import 'package:flutter/material.dart';

import 'bullet_point.dart';

class Ingredient extends StatelessWidget {
  Ingredient({
    Key? key,
    this.ingredientName = '',
  }) : super(key: key);

  String ingredientName;

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
              child: Text(ingredientName,
                  style: const TextStyle(
                    fontSize: 20,
                  )))
        ]));
  }
}
