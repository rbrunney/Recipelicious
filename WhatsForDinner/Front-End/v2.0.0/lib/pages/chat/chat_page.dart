import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:whatsfordinner/pages/chat/log/chat_bubble.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_no_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageNoScrollLayout(
        contents: [
          buildHeader(),
          const Divider(thickness: 1,),
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: const [
                  ChatBubble(isSender: true, message: "Hello David"),
                  ChatBubble(isSender: false, message: "Whats up"),
                  ChatBubble(isSender: true, message: "This is a test for a very long test because messages go brr and its just how it is like sheesh poggers"),
                  ChatBubble(isSender: false, message: "Another very long message becuase your mom said to please try it out so yrrrrrrrrrrrrrrrr a ha ha sheesh"),
                  ChatBubble(isSender: true, message: "Hello David"),
                  ChatBubble(isSender: false, message: "Whats up"),
                  ChatBubble(isSender: true, message: "This is a test for a very long test because messages go brr and its just how it is like sheesh poggers"),
                  ChatBubble(isSender: false, message: "Another very long message becuase your mom said to please try it out so yrrrrrrrrrrrrrrrr a ha ha sheesh"),
                  ChatBubble(isSender: true, message: "Hello David"),
                  ChatBubble(isSender: false, message: "Whats up"),
                  ChatBubble(isSender: true, message: "This is a test for a very long test because messages go brr and its just how it is like sheesh poggers"),
                  ChatBubble(isSender: false, message: "Another very long message becuase your mom said to please try it out so yrrrrrrrrrrrrrrrr a ha ha sheesh")
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: buildChatInput()
            )
          )
        ],
      );
  }

  Container buildHeader() {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        top: MediaQuery.of(context).size.height * 0.025,
        bottom: MediaQuery.of(context).size.height * 0.01
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: "David Ngo",
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(CustomColorPalette.textTitleColor)
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.015),
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: Color(CustomColorPalette.primaryColor),
                            ),
                          ),
                          CustomText(
                              text: "Online Now",
                              fontSize: 12,
                              color: Color(CustomColorPalette.textBodyColor)
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                  Ionicons.close
              ),
            )
          )
        ],
      )
    );
  }

  Container buildChatInput() {

    final TextEditingController chatInputController = TextEditingController();

    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.width * 0.05
        ),
        child: SizedBox(
          height: 50,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
                  child: SizedBox(
                      width: 105,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                              child: Icon(
                                  Ionicons.newspaper_outline,
                                  color: Color(CustomColorPalette.textGray)
                              )
                          ),
                          Expanded(
                              child: Icon(
                                  Ionicons.md_camera_outline,
                                  size: 28,
                                  color: Color(CustomColorPalette.textGray)
                              )
                          ),
                          Expanded(
                            child: Icon(
                                Ionicons.paper_plane_outline,
                                size: 25,
                                color: Color(CustomColorPalette.textGray)
                            ),
                          ),
                        ],
                      )
                  )
                ),
                hintText: 'Message...',
                filled: true,
                fillColor: Color(CustomColorPalette.backgroundGray)
            ),
            cursorColor: Color(CustomColorPalette.textGray),
            controller: chatInputController,
            maxLines: 1,
          ),
        )
    );
  }
}
