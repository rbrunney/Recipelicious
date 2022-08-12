import 'package:flutter/material.dart';

import 'chat_box.dart';
import 'search_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SearchBar(),
              ChatBox(chatBoxName: "Alex Turro",),
              ChatBox(chatBoxName: "David Ngo",),
              ChatBox(chatBoxName: "The Boys", isGroup: true,)
            ]
          )
        ) 
      )
    );
  }
}
