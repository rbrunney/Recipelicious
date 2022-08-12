import 'package:flutter/material.dart';

class MealAppBar extends StatelessWidget {
  const MealAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 25),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              shadowColor: Colors.white,
              toolbarHeight: 1,
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.dining_outlined)),
                  Tab(icon: Icon(Icons.thumb_up_outlined)),
                  Tab(icon: Icon(Icons.bookmark_border_outlined)),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Icon(Icons.dining_outlined),
                Icon(Icons.thumb_up_outlined),
                Icon(Icons.bookmark_border_outlined),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
