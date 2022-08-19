import 'package:flutter/material.dart';

import '../Home/Meal Cards/Back/meal_info.dart';

class ChatMealCard extends StatefulWidget {
  const ChatMealCard({Key? key}) : super(key: key);

  @override
  State<ChatMealCard> createState() => _ChatMealCardState();
}

class _ChatMealCardState extends State<ChatMealCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Card(
          margin: const EdgeInsets.all(10),
          elevation: 2,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                child: const Text(
                  'Name of Meal Here',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
