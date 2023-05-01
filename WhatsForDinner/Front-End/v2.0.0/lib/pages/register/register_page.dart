import 'package:flutter/material.dart';
import 'package:whatsfordinner/pages/additional_info/additional_infomation_page.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';
import 'package:whatsfordinner/util/widgets/page/to_previous_page.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text_field.dart';
import 'package:whatsfordinner/util/widgets/text/page_title.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  void onSubmit() {
    print('Hello World');
    Navigator.push(
        context,
        MaterialPageRoute (
          builder: (BuildContext context) => AccountDetailsPage(username: usernameController.text, password: newPasswordController.text, email: emailController.text),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 2,
                    child: buildHeader()
                ),
                Expanded(
                    flex: 3,
                    child: buildRegisterForm()
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
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.02, left: MediaQuery.of(context).size.width * 0.03),
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Image.asset('./assets/images/updated-icon.png')
          ),
        )
      ],
    );
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  double verticalMargin = 0;
  double horizontalMargin = 0;

  Column buildRegisterForm() {
    verticalMargin = MediaQuery.of(context).size.width * 0.02;
    horizontalMargin = MediaQuery.of(context).size.width * 0.05;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: const PageTitle(title: 'Sign Up'),
        ),
        buildUsernameTextField(),
        buildEmailTextField(),
        buildPasswordTextFields(),
        buildSubmitButton()
      ],
    );
  }

  CustomTextField buildUsernameTextField() {
    return CustomTextField(
        textCallBack: (value) {},
        hintText: "Enter Username...",
        labelText: "Enter Username",
        errorText: null,
        verticalMargin: verticalMargin,
        horizontalMargin: horizontalMargin,
        prefixIcon: Icons.account_circle_outlined,
        textController: usernameController
    );
  }

  String? emailErrorText(TextEditingController emailController) {
    final text = emailController.text;
    RegExp emailCheck = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Simple checks to see if empty or doesn't match regex
    if (!emailCheck.hasMatch(text)) {
      return 'Invalid Email!';
    }

    // Return null is string is valid
    return null;
  }

  CustomTextField buildEmailTextField() {
    return CustomTextField(
        textCallBack: (value) {},
        hintText: "Enter Email...",
        labelText: "Enter Email",
        errorText: emailErrorText(emailController),
        verticalMargin: verticalMargin,
        horizontalMargin: horizontalMargin,
        prefixIcon: Icons.email_outlined,
        textController: emailController
    );
  }

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
            textCallBack: (value) {},
            hintText: "Enter Password...",
            labelText: "Enter Password",
            errorText: newPassErrorText,
            isObscure: true,
            hasSuffixIcon: true,
            suffixIcon: Icons.visibility_off_outlined,
            pressedSuffixIcon: Icons.visibility_outlined,
            verticalMargin: verticalMargin,
            horizontalMargin: horizontalMargin,
            prefixIcon: Icons.lock_outline,
            textController: newPasswordController
        ),
        CustomTextField(
            textCallBack: (value) {},
            hintText: "Confirm Password...",
            labelText: "Confirm Password",
            errorText: confirmNewPassErrorText,
            isObscure: true,
            hasSuffixIcon: true,
            suffixIcon: Icons.visibility_off_outlined,
            pressedSuffixIcon: Icons.visibility_outlined,
            verticalMargin: verticalMargin,
            horizontalMargin: horizontalMargin,
            prefixIcon: Icons.lock_outline,
            textController: confirmNewPasswordController
        )
      ],
    );
  }

  Container buildSubmitButton() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: CustomButton(onTap: (usernameController.text.isNotEmpty && emailController.text.isNotEmpty
            && newPasswordController.text.isNotEmpty && confirmNewPasswordController.text.isNotEmpty)
            ? onSubmit : () {},
            text: 'Submit', hasFillColor: true, color: Color(CustomColorPalette.primaryColor),)
    );
  }
}