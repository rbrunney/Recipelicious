import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:whatsfordinner/pages/meal/ingredient.dart';
import 'package:whatsfordinner/pages/meal/meal_tab_info_bar.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_no_scroll_layout.dart';

import '../../util/widgets/text/custom_text.dart';

class MealStartPage extends StatefulWidget {
  final double rating;
  const MealStartPage({
    Key? key,
    this.rating = 5
  }) : super(key: key);

  @override
  State<MealStartPage> createState() => _MealStartPageState();
}

class _MealStartPageState extends State<MealStartPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageNoScrollLayout(
      contents: [
        buildHeader(),
        buildMainImage(),
        const MealTabInfoBar(),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.03,
            bottom: 0
          ),
          child: const Divider(
            height: 0.5,
            thickness: 1,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.03,
          ),
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.35
          ),
          child: SingleChildScrollView(
            child: Column(
              children: const [
                IngredientCard(ingredientName: "Milk", servingSize: "2 cups",),
                IngredientCard(ingredientName: "Bread", servingSize: "2 slices",),
                IngredientCard(ingredientName: "Ground Beef", servingSize: "5 lbs",),
                IngredientCard(ingredientName: "Cheese", servingSize: "10 cups",),
                IngredientCard(ingredientName: "Pepper", servingSize: "10 cups",),
                IngredientCard(ingredientName: "Salt", servingSize: "10 cups",),
                IngredientCard(ingredientName: "Red Chili Flakes", servingSize: "10 cups",),
                IngredientCard(ingredientName: "Paprika", servingSize: "10 cups",),
                IngredientCard(ingredientName: "Cayenne Pepper", servingSize: "10 cups",),


              ],
            ),
          ),
        ),
        const Spacer(),
        const Divider(thickness: 1.5,),
        buildBottomBar()
      ],
    );
  }

  Container buildHeader() {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        top: MediaQuery.of(context).size.height * 0.04
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: buildPreviousButton(),
          ),
          Expanded(
            flex: 6,
            child: Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1),
              child: CustomText(
                  text: "Cheese Burger",
                  alignment: Alignment.centerLeft,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(CustomColorPalette.textTitleColor)
              )
            )
          )
        ],
      )
    );
  }

  Container buildPreviousButton() {
    return Container(
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Color(CustomColorPalette.backgroundGray),
        child: CircleAvatar(
          radius: 23,
          backgroundColor: Color(CustomColorPalette.white),
          child: IconButton(
            icon: Icon(
                Ionicons.arrow_back_outline,
                size: 25,
                color: Color(CustomColorPalette.primaryColor)
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        )
      )
    );
  }

  Container buildMainImage() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.03,
        horizontal: MediaQuery.of(context).size.width * 0.05
      ),
      child: Stack(
        children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Color(CustomColorPalette.primaryColor),

              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )
              )
            ),
          buildRating(),
          buildCookTime(),
          buildDifficulty(),
        ],
      ),
    );
  }

  Container buildRating() {
    return Container(
      width: 65,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.015,
          left: MediaQuery.of(context).size.width * 0.03
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Color(CustomColorPalette.white),
      ),
      child: Row(
          children: [
            Icon(
                AntDesign.star,
                size: 20,
                color: Color(CustomColorPalette.primaryColor)
            ),
            CustomText(
              text: ' ${widget.rating}',
              color: Color(CustomColorPalette.textBodyColor),
            ),
          ],
        ),
      );
  }

  Container buildCookTime() {
    return Container(
      width: 65,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.15,
        left: MediaQuery.of(context).size.width * 0.03
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Color(CustomColorPalette.white),
      ),
      child: Row(
        children: [
          Icon(
              AntDesign.clockcircle,
              size: 18,
              color: Color(CustomColorPalette.primaryColor)
          ),
          CustomText(
            text: ' ${08}:${59}',
            color: Color(CustomColorPalette.textBodyColor),
          ),
        ],
      ),
    );
  }

  Container buildDifficulty() {
    return Container(
      width: 85,
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.15,
          left: MediaQuery.of(context).size.width * 0.65
      ),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Color(CustomColorPalette.secondaryColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: 'Medium',
            color: Color(CustomColorPalette.white),
          ),
        ],
      ),
    );
  }

  Container buildBottomBar() {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.02,
        top: MediaQuery.of(context).size.height * 0.01
      ),
      alignment: Alignment.bottomCenter,
      child: Row(
          children: [
            buildSaveButton(),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                child: CustomButton(
                  text: "Start Cooking",
                  color: Color(CustomColorPalette.primaryColor),
                  onTap: () {

                  },
                )
              )
            )
          ],
      )
    );
  }

  Container buildSaveButton() {
    return Container(
        child: CircleAvatar(
            radius: 25,
            backgroundColor: Color(CustomColorPalette.backgroundGray),
            child: CircleAvatar(
                radius: 23,
                backgroundColor: Color(CustomColorPalette.white),
                child: IconButton(
                  icon: Icon(
                      Ionicons.bookmark_outline,
                      size: 25,
                      color: Color(CustomColorPalette.primaryColor)
                  ),
                  onPressed: () {
                  },
                )
            )
        )
    );
  }
}
