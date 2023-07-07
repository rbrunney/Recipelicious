import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class ChatBubble extends StatefulWidget {
  final bool isSender;
  final String profileImage;
  final String message;
  const ChatBubble({
    Key? key,
    this.profileImage = '',
    required this.isSender,
    required this.message,
  }) : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return widget.isSender ? buildSenderBubble() : buildReceiverBubble();
  }

  Container buildSenderBubble() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.02
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.width * 0.03,
                left: MediaQuery.of(context).size.width * 0.05
              ),
              decoration: BoxDecoration(
                  color: Color(CustomColorPalette.backgroundGray),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              constraints: const BoxConstraints(
                maxWidth: 270
              ),
              child: Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(CustomColorPalette.textTitleColor)
                    ),
                  )
                )
              )
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                right: MediaQuery.of(context).size.width * 0.05
            ),
            child: const CircleAvatar(
              radius: 15,
            )
          )
        ],
      ),
    );
  }

  Container buildReceiverBubble() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.width * 0.05
              ),
              child: const CircleAvatar(
                radius: 15,
              )
          ),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: MediaQuery.of(context).size.width * 0.02
              ),
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.03
              ),
              decoration: BoxDecoration(
                  color: Color(CustomColorPalette.primaryColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10))
              ),
              constraints: const BoxConstraints(
                  maxWidth: 270
              ),
              child: Flexible(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
                      child: Text(
                        widget.message,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(CustomColorPalette.white)
                        ),
                      )
                  )
              )
          ),
        ],
      ),
    );
  }
}
