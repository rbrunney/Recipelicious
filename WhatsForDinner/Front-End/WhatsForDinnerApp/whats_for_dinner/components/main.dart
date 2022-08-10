import 'package:flutter/material.dart';
import 'util/page_navigation.dart';

void main() {
  runApp(const WhatsForDinner());
}

class WhatsForDinner extends StatelessWidget {
  const WhatsForDinner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const PageNavigation(),
    );
  }
}
