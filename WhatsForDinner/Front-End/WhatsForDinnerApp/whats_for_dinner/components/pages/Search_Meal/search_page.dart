import 'package:flutter/material.dart';
import '../Home/Meal Cards/Front/meal_card.dart';
import '../../util/requests.dart';
import '../../util/globals.dart' as globals;
import 'dart:convert';

enum SingingCharacter { name, creator, ingredients }

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isClicked = false;
  Requests requests = Requests();
  SingingCharacter? _character = SingingCharacter.name;
  TextEditingController searchController = TextEditingController();
  Future<String>? futureSearchInfo;
  List<Widget> searchInformation = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    if (!isSearching) {
      futureSearchInfo = requests.makeGetRequest("http://10.0.2.2:8888/meal");
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: 35,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 3),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Search here',
                              hintText: 'Search here...',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.filter_list_outlined),
                                onPressed: () {
                                  setState(() {
                                    isClicked = !isClicked;
                                  });
                                },
                              )),
                          onFieldSubmitted: (value) {
                            isSearching = true;
                            if (_character == SingingCharacter.name) {
                              futureSearchInfo = requests
                                  .makeGetRequest(
                                      "http://10.0.2.2:8888/meal/findByName/${searchController.text}")
                                  .then((value) {
                                setState(() {});
                                print(value);
                                return value;
                              });
                            }
                            if (_character == SingingCharacter.creator) {
                              futureSearchInfo = requests
                                  .makeGetRequest(
                                      "http://10.0.2.2:8888/meal/findByCreator/${searchController.text}")
                                  .then((value) {
                                setState(() {});
                                print(value);
                                return value;
                              });
                            }
                            if (_character == SingingCharacter.ingredients) {
                              requests
                                  .makeGetRequestWithAuth(
                                      "http://10.0.2.2:8888/fridge/${globals.fridgeID}",
                                      globals.username,
                                      globals.password)
                                  .then((value) {
                                List<Map<String, dynamic>> foundIngredients =
                                    [];
                                print(value);
                                for (var ingredient in json
                                    .decode(value)["result"]["inventory"]) {
                                  ingredient = {
                                    "name": ingredient["name"],
                                    "qty": ingredient["qty"],
                                    "type": ingredient["type"]
                                  };

                                  foundIngredients.add(ingredient);
                                  print(ingredient);
                                }

                                futureSearchInfo = requests.makePostRequestForList(
                                    "http://10.0.2.2:8888/meal/findByIngredients",
                                    foundIngredients);

                                setState(() {});
                                return value;
                              });
                            }
                          }),
                    ),
                  ],
                )),
            if (isClicked)
              Column(children: [
                RadioListTile(
                  title: const Text('name'),
                  value: SingingCharacter.name,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('creator'),
                  value: SingingCharacter.creator,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Your ingredients'),
                  value: SingingCharacter.ingredients,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                  },
                )
              ]),
            if (!isClicked)
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Recommended',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            FutureBuilder<String>(
                future: futureSearchInfo,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> mealInformation =
                        json.decode(snapshot.data!)["results"];
                    searchInformation.clear();
                    for (var meal in mealInformation) {
                      searchInformation.add(MealCard(
                          mealID: meal["id"],
                          mealName: meal["name"],
                          creator: meal["creator"],
                          likes: meal["likes"],
                          ingredients: meal["ingredients"],
                          recipe: meal["recipe"],
                          liked:
                              meal['usersWhoLiked'].contains(globals.username),
                          bookMarked: meal['usersWhoSaved']
                              .contains(globals.username)));
                    }
                    return Column(
                      children: searchInformation,
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
                })
          ]),
        ),
      ),
    );
  }
}
