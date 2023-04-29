import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/page/custom_button.dart';
import 'package:whatsfordinner/util/widgets/page/layouts/base_page_layout.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageLayout(contents: buildContents());
  }
}

List<Widget> buildContents() {
  return [
    CustomButton(
      text: "Login",
        color: Color(CustomColorPalette.primaryColor),
        onTap: () {

    })
  ];
}
