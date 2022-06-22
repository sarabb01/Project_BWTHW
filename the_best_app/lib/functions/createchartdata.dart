import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/functions/elaborateDataFunctions.dart';

List<CircularStackEntry> createChartData(myFitbitData today) {
  return [
    CircularStackEntry([
      CircularSegmentEntry(today.sleepHours * 100 / 7, Colors.redAccent,
          rankKey: 'Sleep'),
      CircularSegmentEntry(100 - today.sleepHours * 100 / 7, Colors.red[100],
          rankKey: 'Sleep')
    ]),
    CircularStackEntry([
      CircularSegmentEntry(today.cardio * 100 / 15, Colors.greenAccent[400],
          rankKey: 'Cardio'),
      CircularSegmentEntry(100 - today.cardio * 100 / 15, Colors.green[100],
          rankKey: 'Cardio')
    ]),
    CircularStackEntry([
      CircularSegmentEntry(today.calories * 100 / 600, Colors.yellowAccent[400],
          rankKey: 'Calories'),
      CircularSegmentEntry(100 - today.calories * 100 / 600, Colors.yellow[100],
          rankKey: 'Calories')
    ]),
    CircularStackEntry([
      CircularSegmentEntry(today.steps * 100 / 10000, Colors.blue[600],
          rankKey: 'Steps'),
      CircularSegmentEntry(100 - today.steps * 100 / 10000, Colors.blue[100],
          rankKey: 'Steps')
    ]), //rankKey: 'Daily objectives')
  ];
}

List<charts.Series<DailyScore, String>> createBarData(
    List<myFitbitData> input) {
  final List<List<DailyScore>> scores = [];
  final List<charts.Series<DailyScore, String>> total = [];

  for (int i = 0; i < input.length; i++) {
    List<double> today_score = elaboratePoints(input[i]);
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
          if (today_score.any((item) => item < 1)) {
            return charts.MaterialPalette.red.shadeDefault.lighter;
          } else {
            return charts.MaterialPalette.green.shadeDefault.lighter;
          }
          ;
        }));
  }

  return total;

  // return [
  //   charts.Series<DailyScore, String>(
  //     id: 'date',
  //     domainFn: (DailyScore points, _) => points.type,
  //     measureFn: (DailyScore points, _) => points.points,
  //     data: scores[1],
  //   ),
  //   charts.Series<DailyScore, String>(
  //     id: 'date',
  //     domainFn: (DailyScore points, _) => points.type,
  //     measureFn: (DailyScore points, _) => points.points,
  //     data: scores[2],
  //   ),
  //   charts.Series<DailyScore, String>(
  //     id: 'date3',
  //     domainFn: (DailyScore points, _) => points.type,
  //     measureFn: (DailyScore points, _) => points.points,
  //     data: scores[3],
  //   ),
  // ];

  // final desktopSalesData = [
  //   new OrdinalSales('2014', 5),
  //   new OrdinalSales('2015', 25),
  //   new OrdinalSales('2016', 100),
  //   new OrdinalSales('2017', 75),
  // ];

  // final tableSalesData = [
  //   new OrdinalSales('2014', 25),
  //   new OrdinalSales('2015', 50),
  //   new OrdinalSales('2016', 10),
  //   new OrdinalSales('2017', 20),
  // ];

  // final mobileSalesData = [
  //   new OrdinalSales('2014', 10),
  //   new OrdinalSales('2015', 15),
  //   new OrdinalSales('2016', 50),
  //   new OrdinalSales('2017', 45),
  // ];

  // return [
  //   new charts.Series<OrdinalSales, String>(
  //     id: 'Desktop',
  //     domainFn: (OrdinalSales sales, _) => sales.year,
  //     measureFn: (OrdinalSales sales, _) => sales.sales,
  //     data: desktopSalesData,
  //   ),
  //   new charts.Series<OrdinalSales, String>(
  //     id: 'Tablet',
  //     domainFn: (OrdinalSales sales, _) => sales.year,
  //     measureFn: (OrdinalSales sales, _) => sales.sales,
  //     data: tableSalesData,
  //   ),
  //   new charts.Series<OrdinalSales, String>(
  //     id: 'Mobile',
  //     domainFn: (OrdinalSales sales, _) => sales.year,
  //     measureFn: (OrdinalSales sales, _) => sales.sales,
  //     data: mobileSalesData,
  //   ),
  // ];
}

// /// Sample ordinal data type.
// class OrdinalSales {
//   final String year;
//   final int sales;

//   OrdinalSales(this.year, this.sales);
// }

class DailyScore {
  final String type;
  final double points;

  DailyScore(this.type, this.points);
}
