import 'package:flutter/material.dart';

class MealCard extends StatefulWidget {
  const MealCard(
      {Key? key,
      this.liked = false,
      this.bookMarked = false,
      })
      : super(key: key);

  final bool liked;
  final bool bookMarked;

  @override
  _MealCard createState() => _MealCard();
}

class _MealCard extends State<MealCard> {
  late bool _liked;
  late bool _bookMarked;

  @override
  void initState() {
    super.initState();
    _liked = false;
    _bookMarked = false;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            const Text('Name of Meal Here'),
            const Image(
                image: NetworkImage('https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg')
                ),
            const Text('This is a test description...'),
            Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_liked
                        ? Icons.thumb_up
                        : Icons.thumb_up_outlined),
                    onPressed: () {
                      setState(() {
                        //need to make request dependent on state
                        _liked = !_liked;
                      });
                    },
                  ),
                  const Text('Likes Go Here'),
                  IconButton(
                    icon: Icon(_bookMarked
                        ? Icons.bookmark 
                        : Icons.bookmark_add_outlined),
                    onPressed: () {
                      setState(() {
                        //need to make request dependent on state
                        _bookMarked = !_bookMarked;
                      });
                    },
                  ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
