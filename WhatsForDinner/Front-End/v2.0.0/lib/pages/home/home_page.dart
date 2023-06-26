import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/meal_info/meal_card.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BasePageScrollLayout(
      contents: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTitle(),
          ],
        ),
        const MealCard(
            isNew: true
        ),
        const MealCard(),
        const MealCard(),
      ],
    );
  }

  Column buildTitle() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.045,
            bottom: MediaQuery.of(context).size.height * 0.005
          ),
          child: CustomText(
              text: "Recipelicious",
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(CustomColorPalette.textTitleColor)
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.025
          ),
          child: CustomText(
              text: "Tasty Adventures Await",
              fontWeight: FontWeight.bold,
              color: Color(CustomColorPalette.textBodyColor)
          )
        )
      ],
    );
  }
}

