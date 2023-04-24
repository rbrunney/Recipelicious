import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  final List<Widget> contents;
  const BasePage({
    Key? key,
    this.contents = const []
  }) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
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
