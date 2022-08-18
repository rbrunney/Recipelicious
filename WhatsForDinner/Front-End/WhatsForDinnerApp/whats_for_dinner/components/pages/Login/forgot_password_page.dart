import 'package:flutter/material.dart';
import '../../util/to_prev_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: const [ToPrevPage(), Text('Forgot Password Page')],
    )));
  }
}
