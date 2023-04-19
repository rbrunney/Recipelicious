import 'package:flutter/material.dart';

import '../../util/requests.dart';
import '../Account/Account_util/add_floating_button.dart';
import 'chat_box.dart';
import 'make_chat_page.dart';
import 'search_bar.dart';
import '../../util/globals.dart' as globals;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  Requests requests = Requests();
  List<Widget> chatBoxs = [
    const SearchBar(),
  ];

  @override
  Widget build(BuildContext context) {
    Future<String>? futureChatGroups = requests.makeGetRequest(
        "http://10.0.2.2:8888/chat/getUserRooms/${globals.userID}");
    return SafeArea(
        child: Scaffold(
            floatingActionButton: const AddFloatingButton(
              btnIcon: Icon(Icons.group_add_outlined),
              widgetPage: MakeChatPage(),
            ),
            body: SingleChildScrollView(
                child: FutureBuilder<String>(
              future: futureChatGroups,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  List<dynamic> chats = json.decode(snapshot.data!);

                  for (var chat in chats) {
                    chatBoxs.add(ChatBox(
                      chatBoxName: chat["groupName"],
                      isGroup: chat["invitedPeople"].length > 2,
                      usersInGroup: chat["invitedPeople"],
                    ));
                  }

                  return Column(
                    children: chatBoxs,
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Center(
                    heightFactor: 20,
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: Colors.tealAccent,
                      ),
                    ));
              }),
            ))));
  }
}
