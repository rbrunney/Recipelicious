import 'package:flutter/material.dart';

import '../../../util/style/style.dart';

class MealImage extends StatefulWidget {
  final String mealImageLink;
  const MealImage({
    super.key,
    this.mealImageLink = "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg"
  });

  @override
  State<MealImage> createState() => _MealImageState();
}

class _MealImageState extends State<MealImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Color(CustomColorPalette.primaryColor),
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image.network(
              widget.mealImageLink,
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )
        )
    );
  }
}
