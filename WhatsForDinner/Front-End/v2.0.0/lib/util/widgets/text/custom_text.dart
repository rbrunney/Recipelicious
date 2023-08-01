import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';

class CustomText extends StatefulWidget {
  int maxLines;
  double topMargin;
  double bottomMargin;
  double leftMargin;
  double rightMargin;
  double fontSize;
  String text;
  Alignment alignment;
  FontWeight fontWeight;
  Color color;

  CustomText({
    Key? key,
    this.topMargin = 0,
    this.bottomMargin = 0,
    this.leftMargin = 0,
    this.rightMargin = 0,
    this.fontSize = 15,
    this.text = '',
    this.maxLines = 1,
    this.alignment = Alignment.center,
    this.fontWeight = FontWeight.normal,
    required this.color,
  }) : super(key: key);

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: widget.topMargin, bottom: widget.bottomMargin, left: widget.leftMargin, right: widget.rightMargin),
        alignment: widget.alignment,
        child: Text(
          widget.text,
          overflow: TextOverflow.visible,
          style: TextStyle(
              fontFamily: TextFont.textFont,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              color: widget.color
          ),
        )
    );
  }
}