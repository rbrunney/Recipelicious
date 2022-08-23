import 'package:flutter/material.dart';
import 'edit_info_page_password.dart';
import '../../../util/to_prev_page.dart';

class EditInfoPage extends StatefulWidget {
  const EditInfoPage(
      {Key? key, this.editProfileInfo = "peepee", this.accountInfo = 'peepee'})
      : super(key: key);

  final String editProfileInfo;
  final String accountInfo;

  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();

    messageController.value = TextEditingValue(
      text: widget.accountInfo,
    );

    if (!widget.editProfileInfo.contains("Password")) {
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const ToPrevPage(),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 80, bottom: 40),
                    child: Text(
                      "Edit ${widget.editProfileInfo}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Edit ${widget.editProfileInfo}'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (messageController.text != '') {
                            Navigator.of(context).pop();
                            await showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        '${widget.editProfileInfo} has been Edited'),
                                    content: Text(
                                        'Your ${widget.editProfileInfo} now has been changed to ${messageController.text}'),
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
                                messageController.clear();
                                print('Call Davids Api');
                          } else {
                            await showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Not all the fields are used'),
                                    content: const Text(
                                        'Please, the field (Name) with the information.'),
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
                        style: ElevatedButton.styleFrom(
                          primary: Colors.tealAccent, // background
                        ),
                        child: Text(
                          'Edit ${widget.editProfileInfo}',
                          style: const TextStyle(color: Colors.black),
                        )),
                  ),
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
