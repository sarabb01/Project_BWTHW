// Flutter Packages
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// Class Description:
class StackedBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;
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
    );
  }
}
