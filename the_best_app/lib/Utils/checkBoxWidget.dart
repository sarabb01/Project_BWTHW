// Flutter Packages
import 'package:flutter/material.dart';

// WIDGET NOT USED IN THIS VERSION OF THE APP
class checkboxWidget extends StatefulWidget {
  const checkboxWidget({Key? key}) : super(key: key);
  @override
  State<checkboxWidget> createState() => _checkboxWidgetState();
}

class _checkboxWidgetState extends State<checkboxWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.green;
      }
      return Colors.black;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
