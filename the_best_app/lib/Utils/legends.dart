import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Legend_rad extends StatelessWidget {
  // final List<String> labels;
  // final List<Color> color;

  // Legend(this.labels, this.color);
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          height: 10,
          width: 10,
          child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue))),
      Text(' Steps'),
      SizedBox(height: 10, width: 10),
      SizedBox(
          height: 10,
          width: 10,
          child: const DecoratedBox(
              decoration: const BoxDecoration(color: Colors.yellowAccent))),
      Text(' Calories'),
      SizedBox(height: 10, width: 10),
      SizedBox(
          height: 10,
          width: 10,
          child: const DecoratedBox(
              decoration: const BoxDecoration(color: Colors.green))),
      Text(' Cardio'),
      SizedBox(height: 10, width: 10),
      SizedBox(
          height: 10,
          width: 10,
          child: const DecoratedBox(
              decoration: const BoxDecoration(color: Colors.red))),
      Text(' Sleep'),
    ]);
  }
}

class Legend_bar extends StatelessWidget {
  // final List<String> labels;
  // final List<Color> color;

  // Legend(this.labels, this.color);
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
          height: 10,
          width: 10,
          child: const DecoratedBox(
              decoration: const BoxDecoration(color: Colors.green))),
      Text(' Target achieved'),
      SizedBox(height: 10, width: 10),
      SizedBox(
          height: 10,
          width: 10,
          child: const DecoratedBox(
              decoration: const BoxDecoration(color: Colors.red))),
      Text(' Target not achieved'),
    ]);
  }
}
