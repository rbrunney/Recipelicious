import 'package:flutter/material.dart';
import 'ordered_recipe.dart';

class AddBarOrdered extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Map<String, dynamic> information;

  const AddBarOrdered(
      {Key? key,
      this.hintText = '',
      this.labelText = '',
      this.information = const {}})
      : super(key: key);

  @override
  State<AddBarOrdered> createState() => _AddBarOrderedState();
}

class _AddBarOrderedState extends State<AddBarOrdered> {
  @override
  Widget build(BuildContext context) {
    TextEditingController addBarController = TextEditingController();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
              controller: addBarController,
              onSubmitted: (value) {
                setState(() {
                  if (widget.information.isEmpty) {
                    widget.information["${widget.information.length + 1}"] =
                        addBarController.text;
                  } else if (!widget.information.keys
                      .contains("${widget.information.length}")) {
                    widget.information["${widget.information.length}"] =
                        addBarController.text;
                  } else {
                    widget.information["${widget.information.length + 1}"] =
                        addBarController.text;
                  }
                });
              },
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (addBarController.text.isNotEmpty) {
                          setState(() {
                            if (widget.information.isEmpty) {
                              widget.information[
                                      "${widget.information.length + 1}"] =
                                  addBarController.text;
                            } else if (!widget.information.keys
                                .contains("${widget.information.length}")) {
                              widget.information[
                                      "${widget.information.length}"] =
                                  addBarController.text;
                            } else {
                              widget.information[
                                      "${widget.information.length + 1}"] =
                                  addBarController.text;
                            }
                          });
                          addBarController.clear();
                        }

                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      icon: const Icon(Icons.add)))),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.information.length,
            itemBuilder: (context, index) {
              index += 1;
              final String ingredient = widget.information["$index"];

              return Dismissible(
                  key: Key(ingredient),
                  onDismissed: (direction) {
                    widget.information.remove("$index");
                  },
                  child: OrderedRecipe(
                    index: index,
                    ingredient: ingredient,
                  ));
            },
          ),
        ),
      ],
    );
  }
}
