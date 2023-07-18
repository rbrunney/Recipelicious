import 'package:flutter/material.dart';
import '../pages/Home/Meal Cards/Back/bullet_point.dart';
import '../pages/Pantry/dropdown_menu.dart';
import '../util/globals.dart' as globals;

class AddBarBullet extends StatefulWidget {
  final String hintText;
  final String labelText;
  final List<dynamic> information;
  final double qty;
  final String measurement;

  const AddBarBullet(
      {Key? key,
      this.hintText = '',
      this.labelText = '',
      this.information = const [],
      this.qty = 0,
      this.measurement = ''})
      : super(key: key);

  @override
  State<AddBarBullet> createState() => _AddBarState();
}

class _AddBarState extends State<AddBarBullet> {
  @override
  Widget build(BuildContext context) {
    TextEditingController addNameController = TextEditingController();
    TextEditingController addQtyController = TextEditingController();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                  controller: addNameController,
                  onSubmitted: (value) {
                    setState(() {
                      widget.information.insert(0, {
                        "name": addNameController.text,
                        "qty": int.parse(addQtyController.text),
                        "measurement": globals.dropdownValue
                      });
                    });
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: widget.hintText,
                      labelText: widget.labelText,
                      prefixIcon: IconButton(
                          onPressed: () {
                            if (addNameController.text.isNotEmpty &&
                                addQtyController.text.isNotEmpty) {
                              setState(() {
                                widget.information.insert(0, {
                                  "name": addNameController.text,
                                  "qty": int.parse(addQtyController.text),
                                  "measurement": globals.dropdownValue
                                });
                              });
                              addNameController.clear();
                            }

                            
                          },
                          icon: const Icon(Icons.add)))),
            ),
            Expanded(
              flex: 1,
              child: TextField(
                controller: addQtyController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Qty...",
                    labelText: 'Qty'),
              ),
            ),
            // Expanded(flex: 1, child: DropdownMenu())
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.information.length,
            itemBuilder: (context, index) {
              final String ingredientName = widget.information[index]["name"];
              final int ingredientQty = widget.information[index]["qty"];
              final String ingredientMeasurement = widget.information[index]["measurement"];


              return Dismissible(
                key: Key(ingredientName),
                onDismissed: (direction) {
                  widget.information.removeAt(index);
                },
                child: Row(
                  children: [
                    const BulletPoint(),
                    Text(
                      '  $ingredientName $ingredientQty($ingredientMeasurement)',
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
