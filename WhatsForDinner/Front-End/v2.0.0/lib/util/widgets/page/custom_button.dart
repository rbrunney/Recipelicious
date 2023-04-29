import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String prefixImagePath;
  final bool hasBorder;
  final bool hasFillColor;
  final Color color;
  final Function()? onTap;
  const CustomButton(
      {
        super.key,
        this.text = '',
        this.prefixImagePath = '',
        this.hasBorder = false,
        this.hasFillColor = false,
        required this.color,
        required this.onTap
      }
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: hasFillColor ? color : Color(CustomColorPalette.primaryColor),
              border: hasBorder ? Border.all(color: Color(CustomColorPalette.lineColor)) : null,
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          child: SizedBox(
            height: 45,
            width: MediaQuery.of(context).size.width * 0.90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                prefixImagePath != ''
                    ? Image.asset(prefixImagePath, height: 32, width: 32)
                    : const Text(''),
                CustomText(
                  text: text,
                  color: Color(CustomColorPalette.white),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  leftMargin: prefixImagePath != '' ? 10 : 0,
                )
              ],
            ),
          )),
    );
  }
}

