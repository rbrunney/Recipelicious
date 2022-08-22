import 'package:flutter/material.dart';
import '../../util/to_prev_page.dart';

class MakeChatPage extends StatefulWidget {
  const MakeChatPage({Key? key}) : super(key: key);

  @override
  _MakeChatPage createState() => _MakeChatPage();
}

class _MakeChatPage extends State<MakeChatPage> {
  List<String> invitedUsers = [];
  bool isBtnActive = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController _inviteUserController = TextEditingController();

    return SafeArea(
        child: Scaffold(
            body: Container(
                child: Column(
      children: [
        const ToPrevPage(),
        Container(
          margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
          child: const Text(
            'Create Group Chat',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 15,
            bottom: 15,
            right: 10,
            left: 10,
          ),
          child: Column(children: [
            TextField(
                controller: _inviteUserController,
                onSubmitted: (value) {
                  setState(() {
                    invitedUsers.insert(0, _inviteUserController.text);
                  });

                  isBtnActive = true;
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Username...',
                    labelText: 'Invite Users',
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (_inviteUserController.text != '' &&
                              invitedUsers.length <= 9) {
                            setState(() {
                              invitedUsers.insert(
                                  0, _inviteUserController.text);
                            });
                            isBtnActive = true;
                            _inviteUserController.clear();
                          }

                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        icon: const Icon(Icons.add)))),
          ]),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: ElevatedButton(
              onPressed: isBtnActive
                  ? () {
                      Navigator.of(context).pop();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                primary: Colors.tealAccent, // background
              ),
              child: const Text(
                'Create Chat',
                style: TextStyle(color: Colors.black),
              )),
        ),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              children: [
                Text(
                  '${invitedUsers.length}/10 Invited Users',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 2, bottom: 2),
                    child: const Text('Swipe to Remove Users'))
              ],
            )),
        Expanded(
            child: ListView.builder(
          itemCount: invitedUsers.length,
          itemBuilder: (context, index) {
            final username = invitedUsers[index];
            return Dismissible(
              key: Key(username),
              onDismissed: (direction) {
                setState(() {
                  invitedUsers.removeAt(index);
                  if (invitedUsers.isEmpty) {
                    isBtnActive = false;
                  }
                });
              },
              child: ListTile(
                title: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Row(children: [
                    const Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 45,
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(invitedUsers[index],
                                style: const TextStyle(fontSize: 20)))),
                  ]),
                ),
              ),
            );
          },
        ))
      ],
    ))));
  }
}
