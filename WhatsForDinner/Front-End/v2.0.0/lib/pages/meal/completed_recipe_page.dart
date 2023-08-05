import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_no_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

import '../../util/style/style.dart';

class CompletedRecipePage extends StatefulWidget {
  const CompletedRecipePage({super.key});

  @override
  State<CompletedRecipePage> createState() => _CompletedRecipePageState();
}

class _CompletedRecipePageState extends State<CompletedRecipePage> {

  @override
  Widget build(BuildContext context) {
    return BasePageNoScrollLayout(
      contents: [
        buildHeader(),
        buildMainImage(),
        buildEngagementButtons(),
        buildCompletedMessage(),
        const Spacer(),
        buildCompleteButton()
      ],
    );
  }

  Container buildHeader() {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        top: MediaQuery.of(context).size.height * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.18
      ),
      child: Column(
        children: [
          CustomText(
            text: "Meal Completed!",
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(CustomColorPalette.textTitleColor),
          )
        ],
      ),
    );
  }

  Container buildMainImage() {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.06
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
            text: ' 4.5',
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
                    Navigator.pop(context);
                  },
                )
            )
        )
    );
  }

  Container buildCommentButton() {
    return Container(
        child: CircleAvatar(
            radius: 25,
            backgroundColor: Color(CustomColorPalette.backgroundGray),
            child: CircleAvatar(
                radius: 23,
                backgroundColor: Color(CustomColorPalette.white),
                child: IconButton(
                  icon: Icon(
                      Ionicons.chatbubble_outline,
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

  Container buildShareButton() {
    return Container(
        child: CircleAvatar(
            radius: 25,
            backgroundColor: Color(CustomColorPalette.backgroundGray),
            child: CircleAvatar(
                radius: 23,
                backgroundColor: Color(CustomColorPalette.white),
                child: IconButton(
                  icon: Icon(
                      Ionicons.share_outline,
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

  Container buildLikeButton() {
    return Container(
        child: CircleAvatar(
            radius: 25,
            backgroundColor: Color(CustomColorPalette.backgroundGray),
            child: CircleAvatar(
                radius: 23,
                backgroundColor: Color(CustomColorPalette.white),
                child: IconButton(
                  icon: Icon(
                      Ionicons.heart_outline,
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

  Container buildEngagementButtons() {
    return Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.15,
          right: MediaQuery.of(context).size.width * 0.15,
          bottom: MediaQuery.of(context).size.height * 0.06
        ),
        child: Row(
          children: [
            Expanded(child: buildLikeButton()),
            Expanded(child: buildCommentButton()),
            Expanded(child: buildSaveButton()),
            Expanded(child: buildShareButton()),
          ],
        )
    );
  }

  Container buildCompletedMessage() {

    Color textColor = Color(CustomColorPalette.textTitleColor);
    double textSize = 20;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05
      ),
      child: Column(
        children: [
          CustomText(
            alignment: Alignment.center,
            text: "Don't stop here chef!",
            fontSize: textSize,
            color: textColor
          ),
          CustomText(
              alignment: Alignment.center,
              text: "There are more recipes to be explored!",
              fontSize: textSize,
              color: textColor
          ),
          CustomText(
            topMargin: 15,
            alignment: Alignment.center,
            text: "Tasty Adventures Await!",
            fontSize: textSize,
            color: textColor,
          ),
        ],
      )
    );
  }

  Container buildCompleteButton() {
    return Container(
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.05,
        left: MediaQuery.of(context).size.width * 0.05,
        bottom: MediaQuery.of(context).size.height * 0.1,
      ),
      child: CustomButton(
        text: "Complete",
        color: Color(CustomColorPalette.primaryColor),
        onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}
