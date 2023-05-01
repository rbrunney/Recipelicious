import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:whatsfordinner/util/style/style.dart';

class ToPrevPage extends StatelessWidget {
  final Color color;
  const ToPrevPage({Key? key, this.color = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: const Icon(Ionicons.chevron_back_outline),
        iconSize: 35,
        color: Color(CustomColorPalette.lineColor),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}