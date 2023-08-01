import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';

import '../../../util/style/style.dart';
import '../../../util/widgets/page/layouts/base_page_no_scroll_layout.dart';
import '../../../util/widgets/text/custom_text.dart';

class RecipeInstructionPage extends StatefulWidget {
  final int totalSteps;
  final int currentStep;
  final double rating;
  const RecipeInstructionPage({
    Key? key,
    required this.totalSteps,
    required this.currentStep,
    required this.rating
  }) : super(key: key);

  @override
  State<RecipeInstructionPage> createState() => _RecipeInstructionPageState();
}

class _RecipeInstructionPageState extends State<RecipeInstructionPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageNoScrollLayout(
      contents: [
        buildHeader(),
        buildProgressBar(),
        buildMainImage(),
        buildRecipeInstruction(),
        buildIngredientsBox(),
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
              child: CustomText(
                  text: "Cheese Burger",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(CustomColorPalette.textTitleColor)
              )
          ),
        ],
      ),
    );
  }

  Container buildProgressBar() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
      child: LinearProgressIndicator(
        color: Color(CustomColorPalette.primaryColor),
        backgroundColor: Color(CustomColorPalette.backgroundGray),
        value: widget.currentStep / widget.totalSteps,
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

  Container buildRecipeInstruction() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Column(
        children: [
          Row(
            children: [
              CustomText(
                  alignment: Alignment.topCenter,
                  text: "${widget.currentStep}",
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Color(CustomColorPalette.textTitleColor)
              ),
              CustomText(
                alignment: Alignment.centerLeft,
                leftMargin: 15,
                text: "Prepare Ingredients",
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(CustomColorPalette.textTitleColor),
              ),
            ],
          ),
          CustomText(
            leftMargin: 55,
            text: "When making this recipe put the ingredients into it so it it poggers. Lets see how far this goes bevause it would be cool to see how far it will actually wrap now this is even more of a test becuasea please just work very poggers poggers so a ha ha",
            fontSize: 18,
            color: Color(CustomColorPalette.textTitleColor)
          )
        ],
      )
    );
  }

  Container buildIngredientsBox() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
      color: Color(CustomColorPalette.backgroundGray),
      child: CustomText(
        alignment: Alignment.centerLeft,
        topMargin: 8,
        bottomMargin: 8,
        leftMargin: 20,
        text: "Ingredients",
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(CustomColorPalette.textGray),
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
      child: CustomButton(
        text: "Next Step",
        color: Color(CustomColorPalette.primaryColor),
        onTap: () {
          if(widget.currentStep != widget.totalSteps) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeInstructionPage(
                  currentStep: widget.currentStep + 1,
                  totalSteps: widget.totalSteps,
                  rating: widget.rating,
                ))
            );
          }
        },
      ),
    );
  }
}
