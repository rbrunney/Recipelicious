import 'package:flutter/material.dart';

class AddFloatingButton extends StatelessWidget {
  const AddFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        onPressed: () {
          print("This is a test, put your hands up!");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
