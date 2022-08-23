import 'package:flutter/material.dart';
import 'pages/Login/login_page.dart';
import 'util/page_navigation.dart';
import './util/globals.dart' as globals;

void main() {
  runApp(const WhatsForDinner());
}

class WhatsForDinner extends StatelessWidget {
  const WhatsForDinner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    // if (!globals.isLoggedIn) {
    //   return MaterialApp(
    //     title: 'Whats For Dinner',
    //     theme: ThemeData.dark(),
    //     home: const LoginPage(),
    //   );
    // }

    return MaterialApp(
      title: 'Whats For Dinner',
      theme: ThemeData.dark(),
      home: const PageNavigation(),
    );
  }
}
