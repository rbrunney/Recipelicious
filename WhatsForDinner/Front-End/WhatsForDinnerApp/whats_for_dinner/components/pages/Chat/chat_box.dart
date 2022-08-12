import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Chat/chat_log.dart';

class ChatBox extends StatelessWidget {
  String chatBoxName;
  bool isGroup;
  ChatBox({Key? key, this.chatBoxName = "", this.isGroup = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Icon(
                isGroup ? Icons.groups_outlined : Icons.account_circle_outlined,
                size: 45,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(chatBoxName, style: const TextStyle(fontSize: 20)),
            ),
            const Expanded(
                flex: 1,
                child: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 30,
                ))
          ])),
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: ChatLog(chatName: chatBoxName,),
            ));
      },
    );
  }
}
