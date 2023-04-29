import 'package:flutter/material.dart';

class BasePageNoScrollLayout extends StatefulWidget {
  final List<Widget> contents;
  const BasePageNoScrollLayout({
    Key? key,
    this.contents = const []
  }) : super(key: key);

  @override
  State<BasePageNoScrollLayout> createState() => _BasePageNoScrollLayoutState();
}

class _BasePageNoScrollLayoutState extends State<BasePageNoScrollLayout> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:Column(
              children: widget.contents,
            ),
          )
      );
  }
}