import 'package:flutter/material.dart';
import '../Home/Meal Cards/Front/meal_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isCreatorChecked = false;
  bool isIngredientsChecked = false;
  bool isLikesChecked = false;
  bool isClicked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.tealAccent;
  }

  @override
  Widget build(BuildContext context) {
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
                        )),
                  ],
                )),
            if (isClicked)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Creator',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Checkbox(
                        checkColor: Colors.black,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isCreatorChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isCreatorChecked = value!;
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Checkbox(
                        checkColor: Colors.black,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isIngredientsChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isIngredientsChecked = value!;
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'likes',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Checkbox(
                        checkColor: Colors.black,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isLikesChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isLikesChecked = value!;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Recommended',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const MealCard(),
            const MealCard(),
            const MealCard(),
            const MealCard(),
            const MealCard(),
          ]),
        ),
      ),
    );
  }
}
