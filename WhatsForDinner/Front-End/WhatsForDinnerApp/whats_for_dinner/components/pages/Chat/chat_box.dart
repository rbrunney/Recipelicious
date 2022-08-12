import 'package:flutter/material.dart';

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
        print('This is a test');
      },
    );
  }
}
