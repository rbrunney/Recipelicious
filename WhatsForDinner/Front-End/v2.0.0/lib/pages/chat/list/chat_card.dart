import 'package:flutter/material.dart';

import '../../../util/style/style.dart';
import '../../../util/widgets/text/custom_text.dart';

class ChatCard extends StatefulWidget {
  final bool hasRecentMessage;
  final bool isLastMessageFromUser;
  final String lastMessage;
  const ChatCard({
    Key? key,
    this.hasRecentMessage = false,
    this.isLastMessageFromUser = false,
    required this.lastMessage
  }) : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  String checkMessageLength(String message) {
    int maxMessageLength = 25;

    if(message.length > maxMessageLength) {
      String newMessage = message.substring(0, maxMessageLength);

      return '${newMessage.trim()}...';
    }

    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: SizedBox(
          height: 85,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                    child: const CircleAvatar(
                      radius: 25,
                    )
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.05,
                    left: MediaQuery.of(context).size.width * 0.03
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.008),
                        child: CustomText(
                          color: Color(CustomColorPalette.textTitleColor),
                          text: "David Ngo",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomText(
                        color: widget.hasRecentMessage ? Color(CustomColorPalette.textTitleColor) : Color(CustomColorPalette.textBodyColor),
                        text: widget.isLastMessageFromUser ? "Me: ${widget.lastMessage}" : checkMessageLength(widget.lastMessage),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.055,
                    left: MediaQuery.of(context).size.width * 0.095
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        color: Color(CustomColorPalette.textBodyColor),
                        text: '08:34 am',
                        fontSize: 13,
                      ),
                      Visibility(
                        visible: widget.hasRecentMessage,
                        child: buildTotalNotifications(3)
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Container buildTotalNotifications(int totalNotifications) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.015),
      child: CircleAvatar(
        backgroundColor: Color(CustomColorPalette.primaryColor),
        radius: 10,
        child: CustomText(
          color: Color(CustomColorPalette.white),
          text: '$totalNotifications',
          fontSize: 13,
        ),
      )
    );
  }
}
