import 'package:flutter/material.dart';

import 'Meal Cards/Front/meal_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Make request to get list of meals

  @override
  Widget build(BuildContext build) {

    return SingleChildScrollView(
      child: Column(
        children: const [
          // Text('Home Page'),
          MealCard(imageUrl: "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",),
          MealCard(imageUrl: "https://d.newsweek.com/en/full/1920025/cat-its-mouth-open.jpg?w=1600&h=1600&q=88&f=b7a44663e082b8041129616b6b73328d",),
          MealCard(imageUrl: "https://www.boredpanda.com/blog/wp-content/uploads/2014/02/funny-wet-cats-coverimage.jpg",),
          MealCard(imageUrl: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F47%2F2020%2F06%2F27%2Fwhite-cat-big-eyes-cat-ledge-1127317526-2000.jpg",),
          MealCard(imageUrl: "https://i.ytimg.com/vi/eX2qFMC8cFo/maxresdefault.jpg",),
          MealCard(imageUrl: "https://i.pinimg.com/originals/32/7e/db/327edb9a15b304efc264668ada03f725.jpg",),
          MealCard(imageUrl: "https://www.top13.net/wp-content/uploads/2015/10/perfectly-timed-funny-cat-pictures-5.jpg",),
          MealCard(imageUrl: "https://static.india.com/wp-content/uploads/2015/10/538.jpg?impolicy=Medium_Resize&w=1200&h=800",),
          MealCard(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ66a6A1tHGHDU8v8ObH3-62Q4AuZlCicpMbg&usqp=CAU",),
          MealCard(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9MRJ2PkWvRNLyk1BZU5kDBfHvvzi-2W72rw&usqp=CAU",),
        ],
      ),
    );
  }
}
