import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
import 'package:the_best_app/Database/Entities/FitbitTables.dart';

List<CircularStackEntry> createChartData(myFitbitData today) {
  return [
    CircularStackEntry([
      CircularSegmentEntry(today.sleepHours * 100 / 7, Colors.blue[600],
          rankKey: 'Sleep'),
      CircularSegmentEntry(100 - today.sleepHours * 100 / 7, Colors.blue[100],
          rankKey: 'Sleep')
    ]),
    CircularStackEntry([
      CircularSegmentEntry(today.cardio * 100 / 15, Colors.greenAccent[400],
          rankKey: 'Cardio'),
      CircularSegmentEntry(100 - today.cardio * 100 / 15, Colors.green[100],
          rankKey: 'Cardio')
    ]),
    CircularStackEntry([
      CircularSegmentEntry(today.calories * 100 / 600, Colors.yellowAccent[700],
          rankKey: 'Calories'),
      CircularSegmentEntry(100 - today.calories * 100 / 600, Colors.yellow[100],
          rankKey: 'Calories')
    ]),
    CircularStackEntry([
      CircularSegmentEntry(today.steps * 100 / 10000, Colors.redAccent,
          rankKey: 'Steps'),
      CircularSegmentEntry(100 - today.steps * 100 / 10000, Colors.red[100],
          rankKey: 'Steps')
    ]), //rankKey: 'Daily objectives')
  ];
}
