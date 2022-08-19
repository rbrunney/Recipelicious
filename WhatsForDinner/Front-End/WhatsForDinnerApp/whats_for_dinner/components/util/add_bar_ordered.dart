import 'package:flutter/material.dart';

class AddBarOrdered extends StatefulWidget {
  final String hintText;
  final String labelText;
  final List<String> information;

  const AddBarOrdered(
      {Key? key,
      this.hintText = '',
      this.labelText = '',
      this.information = const []})
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
                  widget.information.insert(0, addBarController.text);
                });
              },
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (addBarController.text != '') {
                          setState(() {
                            widget.information.insert(0, addBarController.text);
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
              final String ingredient = widget.information[index];

              return Dismissible(
                key: Key(ingredient),
                onDismissed: (direction) {
                  widget.information.removeAt(index);
                },
                child: Row(
                  children: [
                    Text("${index + 1}.", style: const TextStyle(fontSize: 20),),
                    Text(
                      '  $ingredient',
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
