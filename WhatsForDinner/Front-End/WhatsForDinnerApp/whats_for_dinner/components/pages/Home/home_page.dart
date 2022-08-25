import 'package:flutter/material.dart';
import 'dart:convert';

import '../../util/requests.dart';
import 'Meal Cards/Front/meal_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Requests requests = Requests();
  List<Widget> homeInformation = [];

  @override
  Widget build(BuildContext build) {
    Future<String>? futureMealInfo =
        requests.makeGetRequest("http://10.0.2.2:8888/meal");

    return SingleChildScrollView(
        child: Container(
      alignment: Alignment.center,
      child: FutureBuilder<String>(
          future: futureMealInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              List<dynamic> mealInformation =
                  json.decode(snapshot.data!)["results"];

              for (var meal in mealInformation) {
                homeInformation.add(MealCard(
                  mealID: meal["id"],
                  mealName: meal["name"],
                  creator: meal["creator"],
                  likes: meal["likes"],
                  ingredients: meal["ingredients"],
                  recipe: meal["recipe"],
                ));
              }

              return Column(
                children: homeInformation,
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return Center(
                heightFactor: 20,
                child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.tealAccent,
                  ),
                ));
          }),
    ));
  }
}
