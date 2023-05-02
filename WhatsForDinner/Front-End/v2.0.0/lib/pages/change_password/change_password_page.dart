import 'package:flutter/material.dart';
import 'package:whatsfordinner/pages/landing/landing_page.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';
import 'package:whatsfordinner/util/widgets/page/to_previous_page.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text_field.dart';
import 'package:whatsfordinner/util/widgets/text/page_title.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  void onSubmit() {
    if (newPassErrorText == null && confirmNewPassErrorText == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const LandingPage()),
              (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 5,
                    child: buildHeader()
                ),
                Expanded(
                    flex: 6,
                    child: buildChangePasswordForm()
                )
              ],
            )
        )
    );
  }

  Column buildHeader() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
          child: ToPrevPage(color: Color(CustomColorPalette.textTitleColor)),
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.06, left: MediaQuery.of(context).size.width * 0.03),
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Image.asset('./assets/images/updated-icon.png')
          ),
        )
      ],
    );
  }

  Column buildChangePasswordForm() {
    return Column(
      children: [
        buildFormHeader(),
        buildPasswordTextFields(),
        buildChangePasswordButton()
      ],
    );
  }

  Container buildFormHeader() {
    return Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
        child: Column(
            children: const [
              PageTitle(title: 'Reset Password')
            ]
        )
    );
  }

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String? get newPassErrorText {
    final text = newPasswordController.text;

    RegExp specialCharacter = RegExp('[^a-z0-9A-Z]');
    RegExp capitalCharacter = RegExp('[A-Z]');
    RegExp numberCharacter = RegExp('[0-9]');

    if(text.length < 8) {
      return 'New Password must contain at least 8 characters!';
    } else if (!specialCharacter.hasMatch(text)) {
      return 'New Password must contain a special character!';
    } else if (!capitalCharacter.hasMatch(text)) {
      return 'New Password must contain a capital character!';
    } else if (!numberCharacter.hasMatch(text)) {
      return 'New Password must contain a number!';
    }

    return null;
  }

  String? get confirmNewPassErrorText {
    final newPassText = newPasswordController.text;
    final confirmText = confirmNewPasswordController.text;

    if (confirmText != newPassText) {
      return 'Confirm Password does not match!';
    }

    return null;
  }

  Column buildPasswordTextFields() {
    return Column(
      children: [
        CustomTextField(
            horizontalMargin: MediaQuery.of(context).size.width * 0.05,
            textCallBack: (value) {},
            labelText: 'Enter New Password',
            hintText: 'Enter New Password...',
            isObscure: true,
            hasSuffixIcon: true,
            suffixIcon: Icons.visibility_off_outlined,
            pressedSuffixIcon: Icons.visibility_outlined,
            errorText: newPassErrorText,
            prefixIcon: Icons.lock_outline,
            textController: newPasswordController
        ),
        CustomTextField(
            horizontalMargin: MediaQuery.of(context).size.width * 0.05,
            textCallBack: (value) {},
            labelText: 'Confirm New Password',
            hintText: 'Confirm New Password...',
            isObscure: true,
            hasSuffixIcon: true,
            suffixIcon: Icons.visibility_off_outlined,
            pressedSuffixIcon: Icons.visibility_outlined,
            errorText: confirmNewPassErrorText,
            prefixIcon: Icons.lock_outline,
            textController: confirmNewPasswordController
        ),
      ],
    );
  }

  Container buildChangePasswordButton() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: CustomButton(onTap: (newPasswordController.text.isNotEmpty && confirmNewPasswordController.text.isNotEmpty)
            ? onSubmit : () {},
            text: 'Change Password', hasFillColor: true, color: Color(CustomColorPalette.primaryColor),)
    );
  }
}