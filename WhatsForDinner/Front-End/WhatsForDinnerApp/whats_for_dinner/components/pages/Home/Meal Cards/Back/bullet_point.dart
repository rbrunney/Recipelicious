import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  const BulletPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      height: 10,
      width: 10,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle
      ),
    );
  }
}