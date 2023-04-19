import 'dart:convert';

import 'package:flutter/material.dart';
import '../../util/requests.dart';
import '../../util/to_prev_page.dart';
import '../Login/alert_pop_up.dart';
import '../../util/globals.dart' as globals;

class MakeChatPage extends StatefulWidget {
  const MakeChatPage({Key? key}) : super(key: key);

  @override
  _MakeChatPage createState() => _MakeChatPage();
}

class _MakeChatPage extends State<MakeChatPage> {
  Requests requests = Requests();
  List<Map<String, dynamic>> invitedUsers = [];
  bool isBtnActive = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController _inviteUserController = TextEditingController();
    TextEditingController _groupNameController = TextEditingController();

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
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Group Name...',
                    labelText: 'Create Group Name',
                    prefixIcon: Icon(Icons.edit_note_outlined)
              )
            ),
            ),
            TextField(
                controller: _inviteUserController,
                onSubmitted: (value) {
                  requests
                      .makeGetRequest(
                          "http://10.0.2.2:8888/users/getUser/${_inviteUserController.text}")
                      .then(
                    (value) {
                      if (json.decode(value)["result"]) {
                        if (_inviteUserController.text != '' &&
                            invitedUsers.length <= 9 &&
                            _inviteUserController.text != globals.username) {
                          Map<String, dynamic> userInfo = {
                            "userID": json.decode(value)["userID"],
                            "name": json.decode(value)["name"]
                          };

                          if (!invitedUsers.contains(userInfo)) {
                            setState(() {
                              invitedUsers.insert(0, userInfo);
                            });
                          } else {
                            showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertPopUp(
                                    title: 'User Already in Group',
                                    content:
                                        'The user you tried to enter was already part of the group',
                                  );
                                });
                          }

                          isBtnActive = true;
                          _inviteUserController.clear();
                        }

                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        isBtnActive = true;
                      } else {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertPopUp(
                                title: 'User Does Not Exist',
                                content:
                                    'The user currently does not exists in the database, please try another user',
                              );
                            });
                      }
                    },
                  );
                },
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Username...',
                    labelText: 'Invite Users',
                    suffixIcon: IconButton(
                        onPressed: () {
                          requests
                              .makeGetRequest(
                                  "http://10.0.2.2:8888/users/getUser/${_inviteUserController.text}")
                              .then(
                            (value) {
                              if (json.decode(value)["result"]) {
                                if (_inviteUserController.text != '' &&
                                    invitedUsers.length <= 9 &&
                                    _inviteUserController.text !=
                                        globals.username) {
                                  setState(() {
                                    invitedUsers.insert(0, {
                                      "userID": json.decode(value)["userID"],
                                      "name": json.decode(value)["name"]
                                    });
                                  });
                                  isBtnActive = true;
                                  _inviteUserController.clear();
                                }

                                if (_inviteUserController.text ==
                                    globals.username) {
                                  showDialog<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertPopUp(
                                          title: 'Cant Add Yourself',
                                          content:
                                              'You cannot add yourself again to the group',
                                        );
                                      });
                                }

                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              } else {
                                showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertPopUp(
                                        title: 'User Does Not Exist',
                                        content:
                                            'The user currently does not exists in the database, please try another user',
                                      );
                                    });
                              }
                            },
                          );
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
                      invitedUsers.add(
                          {"userID": globals.userID, "name": globals.username});

                      requests.makePostRequest(
                          "http://10.0.2.2:8888/chat/createRoom/", {
                        "groupName": _groupNameController.text,
                        "invitedPeople": invitedUsers
                      }).then((value) {
                        Navigator.of(context).pop();
                      });
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
            final username = invitedUsers[index]["name"];
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
                            child: Text(username,
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
