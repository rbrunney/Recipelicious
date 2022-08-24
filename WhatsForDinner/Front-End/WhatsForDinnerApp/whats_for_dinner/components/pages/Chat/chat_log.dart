import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';

import '../Home/Meal Cards/Front/meal_card.dart';
import 'chat_meal_card.dart';
import '../../util/globals.dart' as globals;
import 'dart:core';

class ChatLog extends StatefulWidget {
  String chatName;
  List<dynamic> invitedUsers;
  ChatLog({Key? key, this.chatName = "", this.invitedUsers = const []})
      : super(key: key);

  @override
  _ChatLog createState() => _ChatLog();
}

class _ChatLog extends State<ChatLog> {
  IO.Socket socket = IO.io(
      'http://10.0.2.2:8888',
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());

  List<Widget> chatLog = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    socket.connect();
    socket.emit("connectToRoom", {
      "groupName": widget.chatName,
      "userID": globals.userID,
      "invitedPeople": widget.invitedUsers,
    });

    socket.emit("getPrevMessages",
        {"groupName": widget.chatName, "userID": globals.userID});
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _messageController = TextEditingController();

    socket.on('room-response', (data) {
      for (var chatInfo in data) {
        if (globals.userID == int.parse(chatInfo['userID'])) {
          if (!mounted) {
            return;
          }
          setState(() {
            chatLog.add(
              ChatBubble(
                margin: const EdgeInsets.only(
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
                alignment: Alignment.centerRight,
                clipper: ChatBubbleClipper4(type: BubbleType.sendBubble),
                backGroundColor: Colors.tealAccent,
                child: Text(
                  chatInfo["content"],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            );
          });
        } else {
          if (!mounted) {
            return;
          }
          setState(() {
            chatLog.add(
              ChatBubble(
                margin: const EdgeInsets.only(
                  right: 10,
                  top: 5,
                  bottom: 5,
                ),
                alignment: Alignment.centerLeft,
                clipper: ChatBubbleClipper4(type: BubbleType.receiverBubble),
                backGroundColor: Colors.grey,
                child: Text(
                  chatInfo["content"],
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            );
          });
        }
      }
    });

    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            socket.emit("disconnectFromRoom", {"groupName": widget.chatName});
            socket.disconnect();
            Navigator.pop(context);
          },
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(widget.chatName, style: const TextStyle(fontSize: 20)),
      ),
      Expanded(
        flex: 7,
        child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.bottomRight,
            child: ListView.builder(
              reverse: true,
              itemCount: chatLog.length,
              itemBuilder: (context, index) => chatLog[index],
            )),
      ),
      Expanded(
        flex: 1,
        child: Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (value) {
                      if (_messageController.text != '') {
                        setState(() {
                          chatLog.insert(
                            0,
                            ChatBubble(
                              margin: const EdgeInsets.only(
                                right: 10,
                                top: 5,
                                bottom: 5,
                              ),
                              alignment: Alignment.centerRight,
                              clipper: ChatBubbleClipper4(
                                  type: BubbleType.sendBubble),
                              backGroundColor: Colors.tealAccent,
                              child: Text(
                                _messageController.text,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                          );
                        });

                        socket.emit("roommessage", {
                          "groupName": widget.chatName,
                          "message": {
                            "userID": globals.userID,
                            "message": _messageController.text
                          }
                        });
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      _messageController.clear();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Type Message...',
                      prefixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            chatLog.insert(0, ChatMealCard());
                          });
                        },
                        icon: const Icon(Icons.dining_outlined),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send_rounded),
                        onPressed: () {
                          if (_messageController.text != '') {
                            setState(() {
                              chatLog.insert(
                                0,
                                ChatBubble(
                                  margin: const EdgeInsets.only(
                                    right: 10,
                                    left: 10,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  alignment: Alignment.centerRight,
                                  clipper: ChatBubbleClipper4(
                                      type: BubbleType.sendBubble),
                                  backGroundColor: Colors.tealAccent,
                                  child: Text(
                                    _messageController.text,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                ),
                              );
                            });

                            socket.emit("roommessage", {
                              "groupName": widget.chatName,
                              "message": {
                                "userID": globals.userID,
                                "name": globals.username,
                                "content": _messageController.text,
                                "postTime": DateTime.now().toString()
                              }
                            });
                          }
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          _messageController.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )),
      )
    ])));
  }
}
