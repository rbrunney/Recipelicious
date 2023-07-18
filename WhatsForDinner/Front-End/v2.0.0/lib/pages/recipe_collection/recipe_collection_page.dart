import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_no_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/search/search_bar.dart';

import '../../util/style/style.dart';

class RecipeCollectionPage extends StatefulWidget {
  const RecipeCollectionPage({Key? key}) : super(key: key);

  @override
  State<RecipeCollectionPage> createState() => _RecipeCollectionPageState();
}

class _RecipeCollectionPageState extends State<RecipeCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageNoScrollLayout(
      contents: [
        const SearchBar(),
        buildFolder()
      ],
    );
  }

  Container buildFolder() {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.30
      ),
      child: buildFolderBack()
    );
  }

  Container buildFolderBack() {
    return Container(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    color: Color(CustomColorPalette.secondaryColor)
                ),
              ),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(CustomColorPalette.primaryColor),
              )
          ),
        ],
      )
    );
  }
}
