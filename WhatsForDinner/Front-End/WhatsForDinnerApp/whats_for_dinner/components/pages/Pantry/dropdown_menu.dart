import 'package:flutter/material.dart';
import '../../util/globals.dart' as globals;

class DropdownMenu extends StatefulWidget {
  const DropdownMenu({Key? key}) : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
// Initial Selected Value
  String selectedValue = 'oz';

// List of items in our dropdown menu
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "oz", child: Text("oz")),
      const DropdownMenuItem(value: "fl oz", child: Text("fl oz")),
      const DropdownMenuItem(value: "lbs", child: Text("lbs")),
      const DropdownMenuItem(value: "tsp", child: Text("tsp")),
      const DropdownMenuItem(value: "tbsp", child: Text("tbsp")),
      const DropdownMenuItem(value: "cup", child: Text("cup")),
      const DropdownMenuItem(value: "pt", child: Text("pt")),
      const DropdownMenuItem(value: "qt", child: Text("qt")),
      const DropdownMenuItem(value: "gal", child: Text("gal")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 52, 50, 50),
        ),
        dropdownColor: Color.fromARGB(255, 52, 50, 50),
        value: selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
            globals.dropdownValue = selectedValue;
          });
        },
        items: dropdownItems);
  }
}
