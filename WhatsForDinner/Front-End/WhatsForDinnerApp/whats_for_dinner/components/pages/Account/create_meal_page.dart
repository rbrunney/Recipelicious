import 'package:flutter/material.dart';
import '../../util/to_prev_page.dart';

class CreateMeal extends StatefulWidget {
  const CreateMeal({Key? key}) : super(key: key);

  @override
  State<CreateMeal> createState() => _CreateMealState();
}

class _CreateMealState extends State<CreateMeal> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: const [
          ToPrevPage(),
        ],
      )),
    ));
  }
}
