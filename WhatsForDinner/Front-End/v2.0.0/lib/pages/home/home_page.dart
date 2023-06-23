import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/meal_info/meal_card.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_no_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePageNoScrollLayout(
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
        CustomText(
            text: "Recipelicious",
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(CustomColorPalette.textTitleColor)
        ),
        CustomText(
          text: "Tasty Adventures Await",
          fontWeight: FontWeight.bold,
          color: Color(CustomColorPalette.textBodyColor)
        )
      ],
    );
  }

}
