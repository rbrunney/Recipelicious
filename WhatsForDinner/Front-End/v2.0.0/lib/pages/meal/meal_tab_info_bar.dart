import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class MealTabInfoBar extends StatefulWidget {
  const MealTabInfoBar({Key? key}) : super(key: key);

  @override
  State<MealTabInfoBar> createState() => _MealTabInfoBarState();
}

class _MealTabInfoBarState extends State<MealTabInfoBar> {

  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      decoration: BoxDecoration(
        color: Color(CustomColorPalette.backgroundGray),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                  isActive = !isActive;
                  });
                },
                child: buildTab("Ingredients", isActive),
              )
            ),
            Expanded(
              child:InkWell(
                onTap: () {
                  setState(() {
                    isActive = !isActive;
                  });
                },
                child: buildTab("Recipe Details", !isActive),
              )
            )
          ],
        ),
      )
    );
  }

  Container buildTab(String name, bool isActive) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.width * 0.03
        ),
        decoration: BoxDecoration(
            color: isActive ? Color(CustomColorPalette.white)
                : Color(CustomColorPalette.backgroundGray),
            borderRadius: BorderRadius.circular(30)
        ),
        child: CustomText(
          text: name,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isActive ? Color(CustomColorPalette.textTitleColor)
              : Color(CustomColorPalette.textGray),
        )
    );
  }
}
