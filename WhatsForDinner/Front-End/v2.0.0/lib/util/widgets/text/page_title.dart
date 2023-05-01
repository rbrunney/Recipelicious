import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final double topMargin;
  final double bottomMargin;
  final Alignment alignment;
  final Color color;
  const PageTitle({
    Key? key,
    this.title = '',
    this.fontSize = 40,
    this.topMargin = 0,
    this.bottomMargin = 15,
    this.alignment = Alignment.centerLeft,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: alignment,
        margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
        child: Text(
          title,
          style: TextStyle(
              fontFamily: TextFont.textFont,
              fontSize: fontSize,
              color: color),
        ));
  }
}