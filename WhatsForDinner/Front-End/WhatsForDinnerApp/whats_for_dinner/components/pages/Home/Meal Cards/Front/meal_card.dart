import 'package:flutter/material.dart';
import '../../../../util/requests.dart';
import '../Back/meal_info.dart';
import 'dart:convert';

class MealCard extends StatefulWidget {
  MealCard(
      {Key? key,
      this.liked = false,
      this.bookMarked = false,
      this.imageUrl =
          "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",
      this.mealID = "",
      this.mealName = "",
      this.likes = 0,
      this.creator = "",
      this.ingredients = const [],
      this.recipe = const {}})
      : super(key: key);

  final bool liked;
  final bool bookMarked;
  final String imageUrl;
  final String mealName;
  int likes;
  final String creator;
  final String mealID;
  final List<dynamic> ingredients;
  final Map<String, dynamic> recipe;

  @override
  _MealCard createState() => _MealCard();
}

class _MealCard extends State<MealCard> {
  late bool _liked;
  late bool _bookMarked;

  Requests requests = Requests();

  @override
  void initState() {
    super.initState();
    _liked = false;
    _bookMarked = false;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 350,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => MealInfo(
                          mealName: widget.mealName,
                          creator: widget.creator,
                          imgUrl: widget.imageUrl,
                          ingredients: widget.ingredients,
                          recipe: widget.recipe,
                        )));
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    widget.imageUrl,
                    width: 350,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                  child: Text(
                    widget.mealName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Text(
                    'Creator: ${widget.creator}',
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          icon: Icon(_liked
                              ? Icons.thumb_up
                              : Icons.thumb_up_outlined),
                          onPressed: () {
                            setState(() {
                              _liked = !_liked;
                            });
                            if (_liked) {
                              requests
                                  .makeGetRequest(
                                      "http://10.0.2.2:8888/meal/like/${widget.mealID}")
                                  .then((value) {
                                setState(() {
                                  widget.likes = json.decode(value)['results'];
                                });
                              });
                            } else {
                              requests
                                  .makeGetRequest(
                                      "http://10.0.2.2:8888/meal/unlike/${widget.mealID}")
                                  .then((value) {
                                setState(() {
                                  widget.likes = json.decode(value)['results'];
                                });
                              });
                            }
                          }),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        widget.likes.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(_bookMarked
                            ? Icons.bookmark
                            : Icons.bookmark_add_outlined),
                        onPressed: () {
                          setState(() {
                            //need to make request dependent on state
                            _bookMarked = !_bookMarked;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
