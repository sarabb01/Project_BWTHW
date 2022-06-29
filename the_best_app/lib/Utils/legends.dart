// Flutter Packages
import 'package:flutter/material.dart';

class Legend_rad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          height: 10,
          width: 10,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(color: Colors.black, width: 0.5)))),
      Text(' Steps'),
      SizedBox(height: 10, width: 10),
      SizedBox(
          height: 10,
          width: 10,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(0xFFFFEA00),
                  border: Border.all(color: Colors.black, width: 0.5)))),
      Text(' Calories'),
      SizedBox(height: 10, width: 10),
      SizedBox(
          height: 10,
          width: 10,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(0xFF00E676),
                  border: Border.all(color: Colors.black, width: 0.5)))),
      Text(' Cardio'),
      SizedBox(height: 10, width: 10),
      SizedBox(
          height: 10,
          width: 10,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(color: Colors.black, width: 0.5)))),
      Text(' Sleep'),
    ]);
  }
}

class Legend_bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          height: 10,
          width: 10,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                  color: Color(0xFFA5D6A7)))),
      Text(' Target achieved'),
      SizedBox(height: 10, width: 10),
      SizedBox(
          height: 10,
          width: 10,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(0xFFEF9A9A),
                  border: Border.all(color: Colors.black, width: 0.5)))),
      Text(' Target not achieved'),
    ]);
  }
}
