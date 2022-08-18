import 'package:flutter/material.dart';
import 'edit_info_page_password.dart';
import '../../../util/to_prev_page.dart';

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
    TextEditingController messageController = TextEditingController();
    if (!widget.editProfileInfo.contains("Password")) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const ToPrevPage(),
              Column(
                children: [
                  Center(
                    heightFactor: 5,
                    child: Text(
                      "Edit ${widget.editProfileInfo}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Edit ${widget.editProfileInfo}'),
                      onSubmitted: (String value) async {
                        messageController.clear();
                        await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  '${widget.editProfileInfo} has been Edited'),
                              content: Text(
                                  'Your ${widget.editProfileInfo} now has been changed to $value'),
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
      return const EditInfoPagePassword();
  }
}
