import 'package:flutter/material.dart';

import '../../util/requests.dart';
import '../../util/to_prev_page.dart';
import '../Account/Account_util/add_floating_button.dart';
import 'chat_box.dart';
import 'make_chat_page.dart';
import 'search_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    // Call Davids Api Here so we can get the list of all chat groups they are in and then
    // Make the list from there

    List<Widget> chatBoxs = [
      const SearchBar(),
    ];

    return SafeArea(
        child: Scaffold(
            floatingActionButton: AddFloatingButton(
              btnIcon: const Icon(Icons.group_add_outlined),
              widgetPage: const MakeChatPage(),
            ),
            body: SingleChildScrollView(child: Column(children: chatBoxs))));
  }
}
