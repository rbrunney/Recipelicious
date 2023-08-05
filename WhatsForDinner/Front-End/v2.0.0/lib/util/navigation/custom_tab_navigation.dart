import 'package:flutter/material.dart';
import 'package:whatsfordinner/util/style/style.dart';
import 'package:whatsfordinner/util/widgets/text/custom_text.dart';

class CustomTabNavigation extends StatefulWidget {
  const CustomTabNavigation({super.key});

  @override
  State<CustomTabNavigation> createState() => _CustomTabNavigationState();
}

class _CustomTabNavigationState extends State<CustomTabNavigation> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        tabs: [
          CustomText(
            text: "Ingredient",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(CustomColorPalette.textGray),
          ),
          CustomText(
            text: "Recipe",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(CustomColorPalette.textGray),
          )
        ],
        indicator: BoxDecoration(
          color: Color(CustomColorPalette.white),
          borderRadius: BorderRadius.circular(100),
        ),
        onTap: (index) {

        },
      )
    );
  }
}
