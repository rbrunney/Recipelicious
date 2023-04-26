import 'package:flutter/material.dart';
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
  return [];
}
