// Flutter packages
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Database
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Functions/elaborateDataFunctions.dart';

// Models
import 'package:the_best_app/models/targetTypes.dart';

/*
Function Description:
This function takes the data (Fitbit data) and the target in input and gives in output data
in the correct format to generate charts
*/

List<CircularStackEntry> createChartData(myFitbitData today, String target) {
  final List values = Target().targets[target]!;
  // STEPS, CLAS, CARDIO, SLEEP
  return [
    CircularStackEntry([
      CircularSegmentEntry(today.sleepHours * 100 / values[3], Colors.redAccent,
          rankKey: 'Sleep'),
      CircularSegmentEntry(
          100 - today.sleepHours * 100 / values[3], Colors.red[100],
          rankKey: 'Sleep')
    ]),
    CircularStackEntry([
      CircularSegmentEntry(
          today.cardio * 100 / values[2], Colors.greenAccent[400],
          rankKey: 'Cardio'),
      CircularSegmentEntry(
          100 - today.cardio * 100 / values[2], Colors.green[100],
          rankKey: 'Cardio')
    ]),
    CircularStackEntry([
      CircularSegmentEntry(
          today.calories * 100 / values[1], Colors.yellowAccent[400],
          rankKey: 'Calories'),
      CircularSegmentEntry(
          100 - today.calories * 100 / values[1], Colors.yellow[100],
          rankKey: 'Calories')
    ]),
    CircularStackEntry([
      CircularSegmentEntry(today.steps * 100 / values[0], Colors.blue[600],
          rankKey: 'Steps'),
      CircularSegmentEntry(
          100 - today.steps * 100 / values[0], Colors.blue[100],
          rankKey: 'Steps')
    ]), //rankKey: 'Daily objectives')
  ];
}

List<charts.Series<DailyScore, String>> createBarData(
    List<myFitbitData> input, String target) {
  final List<List<DailyScore>> scores = [];
  final List<charts.Series<DailyScore, String>> total = [];

  for (int i = 0; i < input.length; i++) {
    List<double> today_score = elaboratePoints(input[i], target);
    final Target values = Target();
    final int steps = values.targets[target]![0];
    final int cals = values.targets[target]![1];
    final int cardio = values.targets[target]![2];
    final int sleep = values.targets[target]![3];

    scores.add([
      DailyScore('Steps', today_score[0]),
      DailyScore('Calories', today_score[1]),
      DailyScore('Cardio', today_score[2]),
      DailyScore('Sleep', today_score[3]),
    ]);

    total.add(charts.Series<DailyScore, String>(
        id: '${input[i].keyDate}',
        domainFn: (DailyScore pts, _) => pts.type,
        measureFn: (DailyScore pts, _) => pts.points,
        data: scores[i],
        // colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        fillColorFn: (_, __) {
          if (input[i].steps > steps &&
              input[i].calories > cals &&
              input[i].cardio > cardio &&
              input[i].sleepHours > sleep) {
            return charts.ColorUtil.fromDartColor(Color(0xFFA5D6A7));
          } else {
            // if (today_score.any((item) => item < 1)) {
            return charts.ColorUtil.fromDartColor(Color(0xFFEF9A9A));
            //MaterialPalette.red.shadeDefault.lighter;

          }
          ;
        }));
  }

  return total;
}

class DailyScore {
  final String type;
  final double points;

  DailyScore(this.type, this.points);
}
