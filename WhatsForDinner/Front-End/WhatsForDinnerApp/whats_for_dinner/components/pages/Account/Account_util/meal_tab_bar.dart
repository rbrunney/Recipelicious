import 'package:flutter/material.dart';
import '../../Home/Meal Cards/Front/meal_card.dart';
import '../create_meal_page.dart';
import 'add_floating_button.dart';

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
            floatingActionButton: AddFloatingButton(widgetPage: CreateMeal(),),
            body: TabBarView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        MealCard(
                            imageUrl:
                                "https://i.ytimg.com/vi/eX2qFMC8cFo/maxresdefault.jpg"),
                        MealCard(
                            imageUrl:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9MRJ2PkWvRNLyk1BZU5kDBfHvvzi-2W72rw&usqp=CAU"),
                        MealCard(
                            imageUrl:
                                "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg"),
                        MealCard(
                            imageUrl:
                                "https://www.boredpanda.com/blog/wp-content/uploads/2014/02/funny-wet-cats-coverimage.jpg"),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        MealCard(
                            imageUrl:
                                "https://static.india.com/wp-content/uploads/2015/10/538.jpg?impolicy=Medium_Resize&w=1200&h=800")
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: const [
                        MealCard(
                            imageUrl:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ66a6A1tHGHDU8v8ObH3-62Q4AuZlCicpMbg&usqp=CAU")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
