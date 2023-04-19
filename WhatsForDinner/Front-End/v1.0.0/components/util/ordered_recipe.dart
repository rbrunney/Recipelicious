import 'package:flutter/material.dart';

class OrderedRecipe extends StatefulWidget {
  const OrderedRecipe({Key? key, this.index = 0, this.ingredient = 'peepee'})
      : super(key: key);

  final int index;
  final String ingredient;

  @override
  State<OrderedRecipe> createState() => _OrderedRecipeState();
}

class _OrderedRecipeState extends State<OrderedRecipe> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${widget.index}.",
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          '  ${widget.ingredient}',
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
