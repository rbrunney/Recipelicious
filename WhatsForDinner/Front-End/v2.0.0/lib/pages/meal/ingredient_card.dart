import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class IngredientCard extends StatefulWidget {
  final String ingredientName;
  final String servingSize;
  const IngredientCard({
    Key? key,
    required this.ingredientName,
    required this.servingSize
  }) : super(key: key);

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                child: isChecked ? Icon(
                  MaterialCommunityIcons.checkbox_marked_outline,
                  size: 40,
                  color: Color(CustomColorPalette.primaryColor),
                ) : Icon(
                    MaterialCommunityIcons.checkbox_blank_outline,
                    size: 40,
                    color: Color(CustomColorPalette.textGray)
                )
            ),
          ),
          Expanded(
            flex: 5,
            child: CustomText(
              alignment: Alignment.centerLeft,
              color: Color(CustomColorPalette.textTitleColor),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              text: widget.ingredientName,
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomText(
              alignment: Alignment.centerRight,
              rightMargin: 8,
              color: Color(CustomColorPalette.textTitleColor),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              text: widget.servingSize,
            ),
          )
        ],
      )
    );
  }
}
