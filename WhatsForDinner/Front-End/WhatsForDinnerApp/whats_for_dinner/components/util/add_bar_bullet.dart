import 'package:flutter/material.dart';
import '../pages/Home/Meal Cards/Back/bullet_point.dart';

class AddBarBullet extends StatefulWidget {
  final String hintText;
  final String labelText;
  final List<dynamic> information;

  const AddBarBullet(
      {Key? key,
      this.hintText = '',
      this.labelText = '',
      this.information = const []})
      : super(key: key);

  @override
  State<AddBarBullet> createState() => _AddBarState();
}

class _AddBarState extends State<AddBarBullet> {
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
                    const BulletPoint(),
                    Text(
                      '  $ingredient',
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                  // const Text("${index + 1}.")
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
