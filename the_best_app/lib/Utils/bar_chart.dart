/// Bar chart example
/// https://pub.dev/packages/charts_flutter
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Functions/createChartdata.dart';

class StackedBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;
//   final charts.BarGroupingType type;
  StackedBarChart(this.seriesList, {this.animate = false});

  /// Creates a stacked [BarChart] with sample data
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
      defaultRenderer: charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.stacked),

      //behaviors: [charts.SeriesLegend()],
    );
  }
}
