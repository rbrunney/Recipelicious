import 'package:flutter/material.dart';
class IconToggleButton extends StatelessWidget {
  final bool isSelected;
  final Function onPressed;
  const IconToggleButton({Key? key, required this.isSelected, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: IconButton(
        iconSize: 30.0,
        padding: EdgeInsets.all(5),
        icon: Padding(
            padding: EdgeInsets.zero,
            child: isSelected == true
                ? const Icon(Icons.dining_outlined)
                : const Icon(Icons.thumb_up_outlined)),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}