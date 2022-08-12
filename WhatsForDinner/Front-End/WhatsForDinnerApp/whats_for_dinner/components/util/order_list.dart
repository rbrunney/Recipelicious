import 'package:flutter/material.dart';

class OrderList extends StatelessWidget {
  List<dynamic> list;
  final double textSize;

  OrderList({Key? key, this.list = const [], this.textSize = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    int counter = 0;
    for (var item in list) {
      counter++;
      widgetList.add(OrderListItem(counter, item, textSize));
      widgetList.add(const SizedBox(
        height: 5,
      ));
    }
    return Column(children: widgetList);
  }
}

class OrderListItem extends StatelessWidget {
  OrderListItem(this.counter, this.item, this.textSize);
  final int counter;
  final double textSize;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$counter. ', style: TextStyle(fontSize: textSize)),
        Container( margin: const EdgeInsets.only(left: 10), child: Text(item, style: TextStyle(fontSize: textSize)))
      ],
    );
  }
}
