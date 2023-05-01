import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:whatsfordinner/controllers/token_controllers/token_controller.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';
import 'package:whatsfordinner/util/widgets/page/to_previous_page.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text_field.dart';
import 'package:whatsfordinner/util/widgets/text/page_title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // final urlController = Get.put(URLController());
  final tokenController = Get.put(TokenController());

  void onSubmit() async {
    // Map<String, dynamic> requestBody = {
    //   "username" : RSA.encrypt(usernameController.text),
    //   "password" : RSA.encrypt(passwordController.text)
    // };
    //
    // await BasicRequest.makePostRequest("${urlController.localBaseURL}/invested_account/authenticate", requestBody)
    //     .then((value) {
    //   var response = json.decode(value);
    //   tokenController.accessToken = response['results']['access-token'];
    //   tokenController.refreshToken = response['results']['refresh-token'];
    //   Navigator.push(
    //       context,
    //       PageTransition(
    //           child: const HomePage(),
    //           type: PageTransitionType.rightToLeftWithFade));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(CustomColorPalette.white),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: buildHeader()
            ),
            Expanded(
                flex: 6,
                child: buildLoginForm()
            )
          ],
        ),
      ),
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
              child: Image.asset('./assets/images/icon.png')
          ),
        )
      ],
    );
  }

  Column buildLoginForm() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: const PageTitle(title: 'Login'),
        ),
        buildUsernameTextField(),
        buildPasswordTextField(),
        buildLoginButton(),
        buildForgotPasswordButton()
      ],
    );
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? get usernameErrorText {
    final text = usernameController.text;

    if (text.isEmpty) {
      return 'Field is Empty!';
    }

    return null;
  }

  CustomTextField buildUsernameTextField() {
    return CustomTextField(
      horizontalMargin: MediaQuery.of(context).size.width * 0.05,
      textCallBack: (value) {},
      hintText: "Enter Username...",
      labelText: "Enter Username",
      prefixIcon: Icons.account_circle_outlined,
      textController: usernameController,
      errorText: usernameErrorText,
    );
  }

  String? get passwordErrorText {
    final text = passwordController.text;

    if (text.isEmpty) {
      return 'Field is Empty!';
    }

    return null;
  }

  CustomTextField buildPasswordTextField() {
    return CustomTextField(
      horizontalMargin: MediaQuery.of(context).size.width * 0.05,
      textCallBack: (value) {},
      hintText: "Enter Password...",
      labelText: "Enter Password",
      isObscure: true,
      hasSuffixIcon: true,
      prefixIcon: Icons.lock_outline,
      suffixIcon: Icons.visibility_off_outlined,
      pressedSuffixIcon: Icons.visibility_outlined,
      textController: passwordController,
      errorText: passwordErrorText,
    );
  }

  Container buildLoginButton() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: CustomButton(onTap: (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty)
            ? onSubmit : () {},
            text: 'Login', hasFillColor: true, color: Color(CustomColorPalette.primaryColor),)
    );
  }

  Container buildForgotPasswordButton() {
    return Container(
        margin: const EdgeInsets.only(top: 5),
        child: CustomButton(onTap: () {
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         child: const ForgotPasswordPage(),
          //         type: PageTransitionType.rightToLeftWithFade));
        },
            text: 'Forgot Password?', hasBorder: true, color: Color(CustomColorPalette.primaryColor),)
    );
  }
}