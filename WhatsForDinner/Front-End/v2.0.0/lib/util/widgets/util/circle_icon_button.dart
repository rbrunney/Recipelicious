import 'package:flutter/material.dart';

import '../../style/style.dart';

class CircleIconButton extends StatefulWidget {
  final IconData icon;
  final Function() onTap;
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap
  });

  @override
  State<CircleIconButton> createState() => _CircleIconButtonState();
}

class _CircleIconButtonState extends State<CircleIconButton> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 25,
        backgroundColor: Color(CustomColorPalette.backgroundGray),
        child: CircleAvatar(
            radius: 23,
            backgroundColor: Color(CustomColorPalette.white),
            child: IconButton(
              icon: Icon(
                  widget.icon,
                  size: 25,
                  color: Color(CustomColorPalette.primaryColor)
              ),
              onPressed: widget.onTap
            )
        )
    );
  }
}
