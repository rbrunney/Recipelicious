import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.05,
            left: MediaQuery.of(context).size.width * 0.05
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  color: Color(CustomColorPalette.textTitleColor),
                  text: "Messages",
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(
                 child: Container(
                   alignment: Alignment.centerRight,
                   margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                   child:  IconButton(
                     onPressed: () {},
                     icon: const Icon(MaterialIcons.group_add, size: 35),
                   ),
                 ),
              )
            ],
          )
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
