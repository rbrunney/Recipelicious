import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class CustomTabNavigation extends StatefulWidget {
  final List<String> tabOptions;
  final List<SingleChildScrollView> tabViewOptions;
  const CustomTabNavigation({
    super.key,
    required this.tabOptions,
    required this.tabViewOptions
  });

  @override
  State<CustomTabNavigation> createState() => _CustomTabNavigationState();
}

class _CustomTabNavigationState extends State<CustomTabNavigation> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CustomText> options = [];
  late final Widget currentView;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: widget.tabOptions.length,
        vsync: this
    );

    for (String option in widget.tabOptions) {
      options.add(
          CustomText(
            text: option,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(CustomColorPalette.textGray),
          )
      );
    }

    currentView = widget.tabViewOptions[0];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                color: Color(CustomColorPalette.backgroundGray),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Color(CustomColorPalette.backgroundGray),
                  width: 2,
                ),
              ),
              child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Color(CustomColorPalette.white),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  tabs: options
              )
          )
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.tabViewOptions,
          ),
        ),
      ],
    );
  }
}
