import 'package:floor/floor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:the_best_app/Utils/dateFormatter.dart';
import 'package:the_best_app/Utils/elaborateDataFunctions.dart';
import 'package:the_best_app/Utils/formats.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Repository/database_repository.dart';

class PointsPage extends StatelessWidget {
  static const route = '/points';
  static const routename = 'Points Page';

  @override
  Widget build(BuildContext context) {
    print('${PointsPage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: Text(PointsPage.routename),
          actions: [
            IconButton(
                onPressed: () async {
                  List<myFitbitData> allData =
                      await Provider.of<UsersDatabaseRepo>(context,
                              listen: false)
                          .findAllFitbitData();
                  print(allData.length);
                  await Provider.of<UsersDatabaseRepo>(context, listen: false)
                      .deleteAllFitbitData(allData);
                },
                icon: Icon(Icons.delete))
          ],
        ),

        // Questo bottone può servire per fetchare!!
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.smart_toy_outlined),
          onPressed: () async {
            List<SleepData> allSleepData =
                await Provider.of<UsersDatabaseRepo>(context, listen: false)
                    .findAllSleepData();
            int totalHours = 0;
            for (int k = 0; k < allSleepData.length; k++) {
              totalHours += allSleepData[k].sleepHours;
            }
            print(totalHours);
          },
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text('TODAY\'S POINTS'),
            Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
              return FutureBuilder(
                  initialData: null,
                  future: dbr.findAllFitbitData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final fitbit = snapshot.data as List<myFitbitData>;
                      final today = fitbit[fitbit.length - 1];
                      //final todayPoints = elaboratePoints(today);
                      // QUI CI VUOLE ELABORAZIONE PERCENTUALI
                      final List<ChartData> chartData = [
                        ChartData('Steps', today.steps * 100 / 10000),
                        ChartData('Calories', today.calories * 100 / 600),
                        ChartData('Cardio', today.cardio * 100 / 15),
                        ChartData('Sleep', today.sleepHours * 100 / 7)
                      ];
                      return fitbit.length == 0
                          ? Text('No activity recorded today')
                          : Container(child: RadialChart(chartData));
                      // Card(
                      //     child: ListTile(
                      //     title: Text(
                      //         '${dateFormatter(DateTime.fromMillisecondsSinceEpoch((fitbit[fitbit.length - 1].keyDate) * Duration.millisecondsPerDay))}'),
                      //     subtitle: Text(
                      //         '${fitbit[fitbit.length - 1].sleepHours}'),
                      //   ));
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            }),
            Text('TOTAL POINTS'),
            Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
              return FutureBuilder(
                  initialData: null,
                  future: dbr.findAllFitbitData(),
                  //future: dbr.findAllSleepData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final fitbit = snapshot.data as List<myFitbitData>;
                      final List total = computeSum(fitbit);
                      print(total);
                      return fitbit.length == 0
                          ? Text('The list is currently empty')
                          : Expanded(
                              child: ListView.builder(
                                //itemCount: fitbit.length,
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Card(
                                      elevation: 3,
                                      child: ListTile(
                                        isThreeLine: true,
                                        leading: Icon(MdiIcons.note),
                                        // title: Text(
                                        //     '${dateFormatter(fitbit[index].date)}'),
                                        title: Text(
                                            'SUMMARY of ${fitbit.length} DAYS'),
                                        // subtitle: Text(
                                        //     'Sleep: ${fitbit[index].sleepHours}, Calories: ${fitbit[index].calories}, Steps: ${fitbit[index].steps}, Minutes Cardio: ${fitbit[index].cardio}'),
                                        subtitle: Text(
                                            'Sleep: ${total[0]}, Calories:${total[1]}, Steps: ${total[2]}, Minutes Cardio: ${total[3]},'),
                                        // onTap: () async {
                                        //   await Provider.of<DatabaseRepository>(
                                        //           context,
                                        //           listen: false)
                                        //       .deleteSleepData(data[index]);
                                        // }
                                      ));
                                },
                              ),
                            );
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            }),
          ]),
        )));
  } //build

} //Page

List<int> computeSum(List<myFitbitData> input) {
  int tot1 = 0;
  int tot2 = 0;
  int tot3 = 0;
  int tot4 = 0;
  for (int k = 0; k < input.length; k++) {
    tot1 += input[k].sleepHours;
    tot2 += input[k].calories;
    tot3 += input[k].steps;
    tot4 += input[k].cardio;
  }
  return [tot1, tot2, tot3, tot4];
}

class RadialChart extends StatelessWidget {
  final List<ChartData> chartData;
  RadialChart(this.chartData);

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(series: <CircularSeries>[
      // Renders radial bar chart
      RadialBarSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y)
    ]);
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
