import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../util/requests.dart';
import '../../util/globals.dart' as globals;
import 'dart:convert';

class IngredientCard extends StatefulWidget {
  String ingredientName;
  int ingredientQty;
  String ingredientType;
  IngredientCard(
      {Key? key,
      this.ingredientName = '',
      this.ingredientQty = 0,
      this.ingredientType = ''})
      : super(key: key);

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  Requests requests = Requests();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                widget.ingredientName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(left: 50, right: 5),
                    child: IconButton(
                        onPressed: () async {
                          if (widget.ingredientQty > 1) {
                            setState(() {
                              widget.ingredientQty--;
                              requests.makePutRequestWithAuth(
                                  "http://10.0.2.2:8888/fridge/${globals.fridgeID}/updateItem",
                                  {
                                    "name": widget.ingredientName,
                                    "qty": widget.ingredientQty,
                                    "type": widget.ingredientType
                                  },
                                  globals.username,
                                  globals.password);
                            });
                          } else {
                            await showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Cannot go lower'),
                                    content: Text(
                                        'Your ${widget.ingredientName} can only go down to 1, if is less than that, just delete it by sliding the ingredient over to any side.'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                          }
                        },
                        icon: const Icon(FontAwesomeIcons.minus))),
                Text(
                  "${widget.ingredientQty} (${widget.ingredientType})",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(left: 5),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.ingredientQty++;
                        requests.makePutRequestWithAuth(
                                  "http://10.0.2.2:8888/fridge/${globals.fridgeID}/updateItem",
                                  {
                                    "name": widget.ingredientName,
                                    "qty": widget.ingredientQty,
                                    "type": widget.ingredientType
                                  },
                                  globals.username,
                                  globals.password);
                      });
                    },
                    icon: const Icon(FontAwesomeIcons.plus),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
