import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class RecipeDetailCard extends StatefulWidget {
  final String title;
  final String detail;
  const RecipeDetailCard({
    Key? key,
    required this.title,
    required this.detail
  }) : super(key: key);

  @override
  State<RecipeDetailCard> createState() => _RecipeDetailCardState();
}

class _RecipeDetailCardState extends State<RecipeDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              text: '${widget.title}:',
              fontSize: 20,
              alignment: Alignment.centerLeft,
              color: Color(CustomColorPalette.textTitleColor),
            ),
          ),
          Expanded(
            child: CustomText(
              text: widget.detail,
              fontSize: 20,
              alignment: Alignment.centerRight,
              color: Color(CustomColorPalette.textTitleColor),
            ),
          )
        ],
      )
    );
  }
}
