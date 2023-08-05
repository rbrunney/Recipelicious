import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:whatsfordinner/models/meal.dart';
import 'package:whatsfordinner/pages/meal/meal_start/meal_start_page.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class MealCard extends StatefulWidget {
  final bool isNew;
  const MealCard({Key? key, this.isNew = false}) : super(key: key);

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MealStartPage())
              );
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    Visibility(visible: widget.isNew, child: buildBadge("New")),
                    buildMealImage(),
                    buildMealInformation(
                        Meal(
                          title: "Cheese Burger",
                          steps: 5,
                          cookingTime: CookingTime(),
                          overallRating: 4.5,
                          totalCalories: 16,
                          difficulty: "Medium"
                    ))
                  ],
                )
              ),
            )
        )
    );
  }

  Container buildMealImage() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.012,
          left: MediaQuery.of(context).size.width * 0.03
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",
            height: MediaQuery.of(context).size.width * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
          )
      )
    );
  }

  Container buildMealInformation(Meal meal) {
    return Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.37),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025),
            child: buildTitle(meal.title),
          ),
          buildStats(meal.overallRating, meal.cookingTime),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
            child: buildDifficulty(meal.difficulty, meal.steps)
          )
        ],
      )
    );
  }

  Row buildTitle(String? mealTitle) {
    return Row(
      children: [
        CustomText(
          text: mealTitle.toString(),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(CustomColorPalette.textTitleColor),
        )
      ],
    );
  }

  Row buildStats(double? rating, CookingTime? time) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03),
          child: Row(
            children: [
              Icon(
                  AntDesign.star,
                  size: 20,
                  color: Color(CustomColorPalette.primaryColor)
              ),
              CustomText(
                  text: " $rating (5)",
                  color: Color(CustomColorPalette.textBodyColor))
            ],
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.01),
              child: Icon(
                AntDesign.clockcircle,
                size: 15,
                color: Color(CustomColorPalette.textBodyColor),
              ),
            ),
            CustomText(
                // text: "${time?.hours}:${time?.minutes}",
              text: "1:45",
                color: Color(CustomColorPalette.textBodyColor))
          ],
        )
      ],
    );
  }

  Row buildDifficulty(String? difficulty, int? totalSteps) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Color(CustomColorPalette.primaryColor),
          ),
          child: CustomText(
            text: difficulty.toString(),
            color: Colors.white,
          ),
        ),
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Color(CustomColorPalette.secondaryColor),
          ),
          child: CustomText(
            text: "$totalSteps steps",
            color: Colors.white,
          ),
        )

      ],
    );
  }

  Row buildBadge(String badgeTitle) {
    return Row(
      children: [
        const Expanded(flex: 5, child: Text('')),
        Expanded(
          flex: 1,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.045,
            width: MediaQuery.of(context).size.width * 0.05,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
              ),
              color: Color(CustomColorPalette.primaryColor),
            ),
            child: CustomText(
              text: badgeTitle,
              color: Color(CustomColorPalette.white),
            ),
          )
        ),
      ],
    );
  }
}
