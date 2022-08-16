import 'package:flutter/material.dart';

class EditInfoPage extends StatefulWidget {
  const EditInfoPage({Key? key, this.editProfileInfo = "peepee"})
      : super(key: key);

  final String editProfileInfo;

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Column(
              children: [
                Center(
                  heightFactor: 5,
                  child: Text(
                    "Edit ${widget.editProfileInfo}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Edit ${widget.editProfileInfo}'),
                    onSubmitted: (String value) async {
                      await showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Name has been Edited'),
                            content: Text(
                                'Your name now has been changed to $value'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
