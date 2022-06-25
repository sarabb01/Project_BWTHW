import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Points_displayer extends StatefulWidget {
  const Points_displayer({Key? key}) : super(key: key);
  @override
  _Points_displayerState createState() => _Points_displayerState();
}

class _Points_displayerState extends State<Points_displayer> {
  double? points;
  @override
  void initState() {
    super.initState();
    _loadPoints();
  }

  // Loading counter value on start
  void _loadPoints() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      if (sp.getDouble('Points') != null) {
        points = sp.getDouble('Points')!.roundToDouble();
      } else {
        points = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Your points $points');
    return Container(
      width: 150,
      height: 22,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 3),
          borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      child: Text(
        ' Your points: $points',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }
}
