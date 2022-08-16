import 'package:flutter/material.dart';

import '../Account/Account_util/add_floating_button.dart';
import 'chat_box.dart';
import 'search_bar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: AddFloatingButton(btnIcon: const Icon(Icons.group_add_outlined),),
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
