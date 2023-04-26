import 'package:flutter/material.dart';

class BasePageLayout extends StatefulWidget {
  final List<Widget> contents;
  const BasePageLayout({
    Key? key,
    this.contents = const []
  }) : super(key: key);

  @override
  State<BasePageLayout> createState() => _BasePageLayoutState();
}

class _BasePageLayoutState extends State<BasePageLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: widget.contents,
          ),
        )
      ),
    );
  }
}
