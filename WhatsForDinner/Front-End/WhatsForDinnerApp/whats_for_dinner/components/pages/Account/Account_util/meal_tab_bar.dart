import 'package:flutter/material.dart';
import '../../../util/requests.dart';
import '../../Home/Meal Cards/Front/meal_card.dart';
import '../create_meal_page.dart';
import 'add_floating_button.dart';
import '../../../util/globals.dart' as globals;
import 'dart:convert';

class MealAppBar extends StatefulWidget {
  const MealAppBar({Key? key}) : super(key: key);

  @override
  _MealAppBar createState() => _MealAppBar();
}

class _MealAppBar extends State<MealAppBar> {
  Requests requests = Requests();
  List<MealCard> usersCreatedMeals = [];
  List<MealCard> usersLikedMeals = [];
  List<MealCard> usersSavedMeals = [];

  @override
  Widget build(BuildContext context) {
    Future<String> getMadeMeals = requests.makeGetRequest(
        "http://10.0.2.2:8888/meal//findByCreator/${globals.username}");

    Future<String> getLikedMeals = requests.makeGetRequest(
        "http://10.0.2.2:8888/meal/getLikedMeals/${globals.username}");

    Future<String> getSavedMeals = requests.makeGetRequest(
        "http://10.0.2.2:8888/meal/getSavedMeals/${globals.username}");

    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              shadowColor: Colors.white,
              toolbarHeight: 1,
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.dining_outlined)),
                  Tab(icon: Icon(Icons.thumb_up_outlined)),
                  Tab(icon: Icon(Icons.bookmark_border_outlined)),
                ],
              ),
            ),
            floatingActionButton: const AddFloatingButton(
              widgetPage: CreateMeal(),
            ),
            body: TabBarView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    child: FutureBuilder<String>(
                        future: getMadeMeals,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            usersCreatedMeals.clear();
                            List<dynamic> mealInformation =
                                json.decode(snapshot.data!)["results"];

                            for (var meal in mealInformation) {
                              usersCreatedMeals.add(MealCard(
                                beingEdited: true,
                                mealID: meal["id"],
                                mealName: meal["name"],
                                creator: meal["creator"],
                                likes: meal["likes"],
                                ingredients: meal["ingredients"],
                                recipe: meal["recipe"],
                              ));
                            }

                            return Column(
                              children: usersCreatedMeals,
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
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    child: FutureBuilder<String>(
                        future: getLikedMeals,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            usersLikedMeals.clear();
                            List<dynamic> mealInformation =
                                json.decode(snapshot.data!)["results"];

                            for (var meal in mealInformation) {
                              usersLikedMeals.add(MealCard(
                                beingEdited: true,
                                mealID: meal["id"],
                                mealName: meal["name"],
                                creator: meal["creator"],
                                likes: meal["likes"],
                                ingredients: meal["ingredients"],
                                recipe: meal["recipe"],
                              ));
                            }

                            return Column(
                              children: usersLikedMeals,
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
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    child: FutureBuilder<String>(
                        future: getSavedMeals,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            usersSavedMeals.clear();
                            List<dynamic> mealInformation =
                                json.decode(snapshot.data!)["results"];

                            for (var meal in mealInformation) {
                              usersSavedMeals.add(MealCard(
                                beingEdited: true,
                                mealID: meal["id"],
                                mealName: meal["name"],
                                creator: meal["creator"],
                                likes: meal["likes"],
                                ingredients: meal["ingredients"],
                                recipe: meal["recipe"],
                              ));
                            }

                            return Column(
                              children: usersSavedMeals,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
