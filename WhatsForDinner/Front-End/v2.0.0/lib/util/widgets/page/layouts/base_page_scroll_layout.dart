import 'package:flutter/material.dart';

class BasePageScrollLayout extends StatefulWidget {
  final List<Widget> contents;
  const BasePageScrollLayout({
    Key? key,
    this.contents = const []
  }) : super(key: key);

  @override
  State<BasePageScrollLayout> createState() => _BasePageScrollLayoutState();
}

class _BasePageScrollLayoutState extends State<BasePageScrollLayout> {
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
