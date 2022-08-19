import 'package:flutter/material.dart';

class AlertPopUp extends StatelessWidget {
  String title;
  String content;
  AlertPopUp({
    Key? key,
  this.title = '',
  this.content = ''
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content:Text(
              content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
  }
}
