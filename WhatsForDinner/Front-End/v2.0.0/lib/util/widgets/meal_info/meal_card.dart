import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
              print('What the nut');
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
                    buildTitle("Cheese Burger"),
                    buildStats(),
                    buildDifficulty("Hard", 3)
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

  Row buildTitle(String mealTitle) {
    return Row(
      children: [
        CustomText(
          text: mealTitle,
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Color(CustomColorPalette.textTitleColor),
        )
      ],
    );
  }

  Row buildStats() {
    return Row(
      children: [
        Row(
          children: [
            Icon(
                AntDesign.star,
              color: Color(CustomColorPalette.primaryColor)
            ),
            CustomText(
              text: "4.5(5)",
                color: Color(CustomColorPalette.textBodyColor))
          ],
        ),
        Row(
          children: [
            const Icon(MaterialCommunityIcons.fire),
            CustomText(
                text: "16 kcal",
                color: Color(CustomColorPalette.textBodyColor))
          ],
        ),
        Row(
          children: [
            const Icon(AntDesign.clockcircle),
            CustomText(
                text: "1:45",
                color: Color(CustomColorPalette.textBodyColor))
          ],
        )
      ],
    );
  }

  Row buildDifficulty(String difficulty, int totalSteps) {
    return Row(
      children: const [

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
