import 'package:flutter/material.dart';

import '../../util/requests.dart';
import '../../util/to_prev_page.dart';
import '../Account/Account_util/add_floating_button.dart';
import 'chat_box.dart';
import 'make_chat_page.dart';
import 'search_bar.dart';
import '../../util/globals.dart' as globals;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  Requests requests = Requests();

  @override
  Widget build(BuildContext context) {
    // Call Davids Api Here so we can get the list of all chat groups they are in and then
    // Make the list from thern

    List<Widget> chatBoxs = [
      const SearchBar(),
    ];

    requests
        .makeGetRequest(
            "http://10.0.2.2:8888/chat/getUserRooms/${globals.userID}")
        .then(
      (value) {
        print(value);
      },
    );

    return SafeArea(
        child: Scaffold(
            floatingActionButton: const AddFloatingButton(
              btnIcon: Icon(Icons.group_add_outlined),
              widgetPage: MakeChatPage(),
            ),
            body: SingleChildScrollView(child: Column(children: chatBoxs))));
  }
}
