import 'package:flutter/material.dart';
import 'package:whatsfordinner/pages/chat/list/chat_card.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/search/search_bar.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageScrollLayout(
      contents: [
        CustomText(
          color: Color(CustomColorPalette.textTitleColor),
          text: "Messages",
          fontSize: 35,
          fontWeight: FontWeight.bold,
          alignment: Alignment.centerLeft,
        ),
        const SearchBar(),
        const ChatCard(
          hasRecentMessage: true,
          lastMessage: "Hello this is  from test David",
        ),
        const ChatCard(
          lastMessage: "Your Mom"
        ),
        const ChatCard(
            lastMessage: "Your Mom"
        ),
        const ChatCard(
            lastMessage: "Your Mom"
        ),const ChatCard(
            lastMessage: "Your Mom"
        ),const ChatCard(
            lastMessage: "Your Mom"
        ),



      ],
    );
  }
}
