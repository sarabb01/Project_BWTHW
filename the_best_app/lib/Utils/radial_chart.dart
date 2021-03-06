// Flutter Packages
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:colours/colours.dart';
import 'package:flutter/cupertino.dart';

class RadialChart extends StatefulWidget {
  RadialChart({Key? key, required this.chartData, required this.pointsData})
      : super(key: key);
  final List<CircularStackEntry> chartData;
  final List<double> pointsData;
  @override
  State<RadialChart> createState() => _RadialChartState();
}

class _RadialChartState extends State<RadialChart> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  @override
  Widget build(BuildContext context) {
    double sum = widget.pointsData.fold(0, (prev, element) => prev + element);
    return AnimatedCircularChart(
        key: _chartKey,
        size: const Size(250.0, 250.0),
        initialChartData: widget.chartData,
        chartType: CircularChartType.Radial,
        edgeStyle: SegmentEdgeStyle.round,
        percentageValues: true,
        holeRadius: 60.0,
        holeLabel: 'Your score: ${sum.toStringAsFixed(2)}',
        labelStyle: new TextStyle(
            color: Colours.darkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 15.0));
  }
}
