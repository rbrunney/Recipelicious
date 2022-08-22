import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AddFloatingButton extends StatelessWidget {
  final Icon btnIcon;
  final Widget widgetPage;
  const AddFloatingButton({
    Key? key,
    this.btnIcon = const Icon(Icons.add),
    this.widgetPage = const SafeArea(
      child: Scaffold(
        body: Text('What the nut check yourslef')
      )    
    )
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: widgetPage
            ));
        },
        child: btnIcon,
      ),
    );
  }
}
