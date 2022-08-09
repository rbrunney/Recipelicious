import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  const MealCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints (
        maxWidth: 200
      ),
      child: const DefaultTextStyle(
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
        child: Text('This is a test'),
      ),
      // child: Container(
      //   child: Column(
      //     children: const [
      //       Text('Name of Meal Here'),
      //       Image(
      //           image: NetworkImage('https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg')
      //       ),
      //       Text('This is a test description'),
      //       Icon(Icons.heat_pump_rounded),
      //       Text('Likes Go Here'),
      //       Icon(Icons.file_copy_outlined)
      //     ],
      //   ),
      // ),
    );
  }
}
