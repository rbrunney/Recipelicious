import 'package:flutter/material.dart';

class MealCard extends StatefulWidget {
  const MealCard({
    Key? key,
    this.liked = false,
    this.bookMarked = false,
  }) : super(key: key);

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
        constraints: const BoxConstraints(
          maxWidth: 350,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  body: Center(
                    child: TextButton(
                      child: Text('Icon Needs to Go Here'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ));
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    "https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg",
                    width: 350,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                  child: const Text(
                    'Name of Meal Here',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: const Text(
                    'This is a test description...',
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(
                            _liked ? Icons.thumb_up : Icons.thumb_up_outlined),
                        onPressed: () {
                          setState(() {
                            //need to make request dependent on state
                            _liked = !_liked;
                          });
                        },
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Text(
                        '0',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
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
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
