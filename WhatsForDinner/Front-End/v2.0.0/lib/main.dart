import 'package:flutter/material.dart';
import 'package:whatsfordinner/pages/home/home_page.dart';
import 'package:whatsfordinner/pages/landing/landing_page.dart';

void main() {
  runApp(const WhatsForDinner());
}

class WhatsForDinner extends StatelessWidget {
  const WhatsForDinner({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
