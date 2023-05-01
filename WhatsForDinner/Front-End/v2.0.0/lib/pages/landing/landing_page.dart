import 'package:flutter/material.dart';
import 'package:whatsfordinner/pages/login/login_page.dart';
import 'package:whatsfordinner/pages/register/register_page.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_no_scroll_layout.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageNoScrollLayout(contents: buildContents());
  }

  List<Widget> buildContents() {
    return [
      const Expanded(
        flex: 3,
        child: Placeholder(),
      ),
      Expanded(
          flex: 1,
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CustomButton(
                      text: "Get Started",
                      color: Color(CustomColorPalette.primaryColor),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute (
                              builder: (BuildContext context) => const RegisterPage(),
                            )
                        );
                      }),
                ),
                Container(
                    alignment: Alignment.center,
                    child: CustomButton(
                      text: 'Continue with Google',
                      prefixImagePath: './assets/images/google_logo.png',
                      color: Color(CustomColorPalette.lineColor),
                      onTap: () {  },
                    )
                ),
                createLoginText()
              ],
            ),
          )
      )
    ];
  }

  Container createLoginText() {
    return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.025),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                text: "Already have an account? ",
                fontSize: 17,
                color: Color(CustomColorPalette.textTitleColor)
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: CustomText(
                    text: "Log in",
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(CustomColorPalette.primaryColor)
                )
            )
          ],
        )
    );
  }
}
