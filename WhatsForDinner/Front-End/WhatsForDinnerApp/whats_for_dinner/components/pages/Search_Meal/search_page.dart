import 'package:flutter/material.dart';
import '../Chat/search_bar.dart';
import '../Home/Meal Cards/Front/meal_card.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: const [
            SearchBar(),
            MealCard(),
            MealCard(),
            MealCard(),
            MealCard(),
            MealCard(),
        
          ]),
        ),
      ),
    );
  }
}
