import 'package:flutter/material.dart';

import '../../../../util/order_list.dart';

class Recipe extends StatelessWidget {
  List<String> recipe;
  Recipe({Key? key, this.recipe = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> recipeList = [
      const Text('Recipe',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
    ];

    recipeList.add(OrderList(list: recipe, textSize: 20,));

    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 25
      ),
      child: Column(children: recipeList));
  }
}
