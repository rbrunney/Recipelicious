import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:whatsfordinner/util/style/style.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  final TextEditingController searchController = TextEditingController();

  bool goodToClearText = false;

  @override
  Widget build(BuildContext context) {
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
              prefixIcon: Icon(
                Ionicons.search,
                color: Color(CustomColorPalette.textGray),
              ),
              suffixIcon: goodToClearText ? IconButton(
                icon: const Icon(Ionicons.close_circle_outline),
                color: Color(CustomColorPalette.textGray),
                onPressed: () {
                  setState(() {
                    searchController.text = '';
                    goodToClearText = false;
                  });
                },
              ) : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              hintText: 'Search...',
              filled: true,
              fillColor: Color(CustomColorPalette.backgroundGray)
          ),
          cursorColor: Color(CustomColorPalette.textGray),
          controller: searchController,
          maxLines: 1,
          onChanged: (text) {
            if(text.isNotEmpty) {
              setState(() {
                goodToClearText = true;
              });
            }
          },
        ),
      )
    );
  }
}
