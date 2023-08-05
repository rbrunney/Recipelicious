import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsfordinner/pages/meal/ingredient_card.dart';
import 'package:whatsfordinner/pages/meal/util/meal_image.dart';
import 'package:whatsfordinner/pages/meal/recipe_detial_card.dart';
import 'package:whatsfordinner/pages/meal/recipe_instruction/recipe_instruction_page.dart';
import 'package:whatsfordinner/util/navigation/custom_tab_navigation.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_no_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/util/circle_icon_button.dart';
import 'package:whatsfordinner/util/widgets/util/meal_stat.dart';

import '../../../util/widgets/text/custom_text.dart';

class MealStartPage extends StatefulWidget {
  final double rating;
  bool isSaved;
  MealStartPage({
    Key? key,
    this.rating = 5,
    this.isSaved = false
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
        buildTabNavigation(),
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
              children: buildRecipeDetails(),
            ),
          ),
        ),
        const Spacer(),
        const Divider(thickness: 1.5,),
        buildBottomBar()
      ],
    );
  }

  Container buildTabNavigation() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05
      ),
      child: const CustomTabNavigation()
    );
  }

  List<Widget> buildRecipeDetails() {
    return const [
      RecipeDetailCard(title: "Chef", detail: "rbrunney",),
      RecipeDetailCard(title: "Likes", detail: "504 likes",),
      RecipeDetailCard(title: "Saves", detail: "201 saves",),
      RecipeDetailCard(title: "Total Steps", detail: "5 steps",),
    ];
  }

  List<Widget> buildIngredients() {
    return const [
      IngredientCard(ingredientName: "Milk", servingSize: "2 cups",),
      IngredientCard(ingredientName: "Bread", servingSize: "2 slices",),
      IngredientCard(ingredientName: "Ground Beef", servingSize: "5 lbs",),
      IngredientCard(ingredientName: "Cheese", servingSize: "10 cups",),
      IngredientCard(ingredientName: "Pepper", servingSize: "10 cups",),
      IngredientCard(ingredientName: "Salt", servingSize: "10 cups",),
      IngredientCard(ingredientName: "Red Chili Flakes", servingSize: "10 cups",),
      IngredientCard(ingredientName: "Paprika", servingSize: "10 cups",),
      IngredientCard(ingredientName: "Cayenne Pepper", servingSize: "10 cups",),
    ];
  }

  Container buildHeader() {
    final double sideMargin = MediaQuery.of(context).size.height * 0.02;

    return Container(
      margin: EdgeInsets.only(
        left: sideMargin,
        right: sideMargin,
        top: MediaQuery.of(context).size.height * 0.04
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: buildPreviousButton(),
          ),
          Expanded(
            flex: 4,
            child: CustomText(
                text: "Cheese Burger",
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(CustomColorPalette.textTitleColor)
            )
          ),
          Expanded(
            flex: 1,
            child: buildShareButton()
          )
        ],
      )
    );
  }

  CircleIconButton buildPreviousButton() {
    return CircleIconButton(
      icon: Ionicons.arrow_back_outline,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  CircleIconButton buildShareButton() {
    return CircleIconButton(
        icon: Ionicons.share_outline,
        onTap: () async {
          await Share.share('Check this out');
        }
    );
  }

  Container buildMainImage() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.025,
        horizontal: MediaQuery.of(context).size.width * 0.05
      ),
      child: const MealImage()
    );
  }

  Container buildMealStats() {
    final double sideMargin = MediaQuery.of(context).size.width * 0.05;
    return Container(
      margin: EdgeInsets.only(
        left: sideMargin,
        right: sideMargin,
        bottom: MediaQuery.of(context).size.height * 0.015
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Expanded(
            child: MealStat(
                icon: FontAwesome.star_o,
                stat: "4.6"
            ),
          ),
          Expanded(
            child: MealStat(
                icon: Ionicons.alarm_outline,
                stat: "8:46"
            ),
          ),
          Expanded(
              child: MealStat(
                  icon: Ionicons.flag_outline,
                  stat: "Medium"
              )
          )
        ],
      )
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecipeInstructionPage(
                          currentStep: 7,
                          totalSteps: 12,
                          rating: widget.rating,
                        ))
                    );
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
                  icon: widget.isSaved ? Icon(
                    Ionicons.bookmark,
                    size: 25,
                    color: Color(CustomColorPalette.primaryColor)
                  ) : Icon(
                      Ionicons.bookmark_outline,
                      size: 25,
                      color: Color(CustomColorPalette.primaryColor)
                  ),
                  onPressed: () async {
                    setState(() {
                      widget.isSaved = !widget.isSaved;
                    });
                  },
                )
            )
        )
    );
  }
}
