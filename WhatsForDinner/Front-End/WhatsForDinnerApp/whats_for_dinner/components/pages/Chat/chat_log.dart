import 'dart:async';

import 'package:flutter/material.dart';

class ChatLog extends StatelessWidget {
  String chatName;
  ChatLog({
    Key? key,
    this.chatName = ""
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Text(chatName),
          ]
        )   
      )
    );
  }
}
