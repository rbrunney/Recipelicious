import 'package:flutter/material.dart';

import '../Home/Meal Cards/Back/meal_info.dart';

class ChatMealCard extends StatefulWidget {
  bool isUpvoted;
  int upvoteCount;
  bool isDownVoted;
  int downVoteCount;
  String imageUrl;
  ChatMealCard(
      {Key? key,
      this.isUpvoted = false,
      this.isDownVoted = false,
      this.upvoteCount = 0,
      this.downVoteCount = 0,
      this.imageUrl =
          'https://i.pinimg.com/736x/ba/92/7f/ba927ff34cd961ce2c184d47e8ead9f6.jpg'})
      : super(key: key);

  @override
  State<ChatMealCard> createState() => _ChatMealCardState();
}

class _ChatMealCardState extends State<ChatMealCard> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 250,
      ),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => MealInfo(
                          imgUrl: widget.imageUrl,
                        )));
          },
          child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image.network(
                      widget.imageUrl,
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
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (widget.isUpvoted) {
                                        widget.isUpvoted = false;
                                        widget.upvoteCount -= 1;
                                      } else {
                                        widget.isUpvoted = true;
                                        widget.upvoteCount += 1;
                                      }

                                      if (widget.isDownVoted) {
                                        widget.isDownVoted = false;
                                        widget.downVoteCount -= 1;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.arrow_circle_up_outlined,
                                    color: widget.isUpvoted
                                        ? Colors.tealAccent
                                        : Colors.grey,
                                  ),
                                ),
                                Text('${widget.upvoteCount}')
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (widget.isDownVoted) {
                                          widget.isDownVoted = false;
                                          widget.downVoteCount -= 1;
                                        } else {
                                          widget.isDownVoted = true;
                                          widget.downVoteCount += 1;
                                        }

                                        if (widget.isUpvoted) {
                                          widget.isUpvoted = false;
                                          widget.upvoteCount -= 1;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.arrow_circle_down_outlined,
                                      color: widget.isDownVoted
                                          ? Colors.tealAccent
                                          : Colors.grey,
                                    )),
                                Text('${widget.downVoteCount}')
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
