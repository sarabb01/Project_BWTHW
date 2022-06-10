// /// Bar chart example
// /// https://pub.dev/packages/charts_flutter
// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class StackedBarChart extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;
//   final charts.BarGroupingType type;

//   StackedBarChart(this.seriesList, this.type, {required this.animate});

//   /// Creates a stacked [BarChart] with sample data and no transition.
//   // factory StackedBarChart.withSampleData() {
//   //   return new StackedBarChart(
//   //     _createSampleData(),
//   //     charts.BarGroupingType.stacked,
//   //     // Disable animations for image tests.
//   //     animate: false,
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return new StackedBarChart(
//       seriesList,
//       type,
//       animate: animate,
//     );
//   }

//   /// Create series list with multiple series

//   List<charts.Series<OrdinalSales, String>> createSampleData() {
//     final desktopSalesData = [
//       new OrdinalSales('2014', 5),
//       new OrdinalSales('2015', 25),
//       new OrdinalSales('2016', 100),
//       new OrdinalSales('2017', 75),
//     ];

//     final tableSalesData = [
//       new OrdinalSales('2014', 25),
//       new OrdinalSales('2015', 50),
//       new OrdinalSales('2016', 10),
//       new OrdinalSales('2017', 20),
//     ];

//     final mobileSalesData = [
//       new OrdinalSales('2014', 10),
//       new OrdinalSales('2015', 15),
//       new OrdinalSales('2016', 50),
//       new OrdinalSales('2017', 45),
//     ];

//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Desktop',
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: desktopSalesData,
//       ),
//       new charts.Series<OrdinalSales, String>(
//         id: 'Tablet',
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: tableSalesData,
//       ),
//       new charts.Series<OrdinalSales, String>(
//         id: 'Mobile',
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: mobileSalesData,
//       ),
//     ];
//   }
// }

// /// Sample ordinal data types
// class OrdinalSales {
//   final String year;
//   final int sales;

//   OrdinalSales(this.year, this.sales);
// }
