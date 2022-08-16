import 'package:flutter/material.dart';
import '../Edit_pages/edit_info_page.dart';
import 'package:page_transition/page_transition.dart';

class AccountEditInfo extends StatefulWidget {
  const AccountEditInfo(
      {Key? key,
      this.accountInfo = "peepee",
      this.editProfileInfo = "cool peepee"})
      : super(key: key);

  final String accountInfo;
  final String editProfileInfo;

  @override
  State<AccountEditInfo> createState() => _AccountEditInfoState();
}

class _AccountEditInfoState extends State<AccountEditInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 10,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            widget.accountInfo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: IconButton(
          icon: const Icon(Icons.edit_outlined),
          alignment: Alignment.centerRight,
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: EditInfoPage(editProfileInfo: widget.editProfileInfo)),
            );
          },
        ),
      ),
    ]);
  }
}
