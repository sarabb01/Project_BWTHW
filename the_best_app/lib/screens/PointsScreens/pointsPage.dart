//PACKAGES
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:colours/colours.dart';
import 'package:floor/floor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

//Functions
import 'package:the_best_app/functions/createchartdata.dart';
import 'package:the_best_app/functions/dateFormatter.dart';
import 'package:the_best_app/functions/elaborateDataFunctions.dart';
import 'package:the_best_app/Utils/formats.dart';

//WIDGETS
import 'package:the_best_app/Utils/radial_chart.dart';
import 'package:the_best_app/Utils/bar_chart.dart';

//DATABASE AND REPO
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/functions/fetchdata.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class PointsPage extends StatelessWidget {
  static const route = '/hellowordpage/loginpage/homepage/pointspage';
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
                  final sp = await SharedPreferences.getInstance();
                  final double score = computeTotalPoints(allData);
                  sp.setDouble('Points', score);
                  print('${allData.length}, ${sp.getDouble('Points')}');
                },
                icon: Icon(Icons.update))
          ],
        ),

        // Questo bottone può servire per fetchare!!
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.smart_toy_outlined),
            onPressed: () async {
              fetchData(context);
            }
            //   List<SleepData> allSleepData =
            //       await Provider.of<UsersDatabaseRepo>(context, listen: false)
            //           .findAllSleepData();
            //   int totalHours = 0;
            //   for (int k = 0; k < allSleepData.length; k++) {
            //     totalHours += allSleepData[k].sleepHours;
            //   }
            //   print(totalHours);
            // },
            ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
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

                      print(
                          '${dateFormatter(DateTime.fromMillisecondsSinceEpoch((fitbit[fitbit.length - 1].keyDate) * Duration.millisecondsPerDay))}');
                      final today = fitbit[fitbit.length - 1];
                      final todayPoints = elaboratePoints(today);
                      // QUI CI VUOLE ELABORAZIONE PERCENTUALI
                      final List<CircularStackEntry> chartData =
                          createChartData(today);

                      return fitbit.length == 0
                          ? Text('No activity recorded today')
                          : Container(
                              child: GestureDetector(
                              onLongPress: () {
                                //This function will subtract points;
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          'POINTS SUMMARY',
                                          textAlign: TextAlign.center,
                                        ),
                                        titleTextStyle: TextStyle(
                                            color: Colours.darkGreen,
                                            fontSize: 25),
                                        content: Text(
                                          'Steps ${(todayPoints[0] * 100).toStringAsFixed(1)}%\n${today.steps} / 10000 \n\nCalories ${todayPoints[1] * 100}%\n${today.calories} / 600 \n\nCardio ${todayPoints[2] * 100}%\n${today.cardio} / 15 \n\nSleep ${(todayPoints[3] * 100).toStringAsFixed(1)}%\n${today.sleepHours} / 7',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                        backgroundColor: Colours.whiteSmoke,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        //margin: EdgeInsets.fromLTRB(50, 450, 50, 200),
                                        actions: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              }, // TO BE IMPLEMENTED
                                              icon: Icon(
                                                Icons.check_circle,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )),
                                        ],
                                        actionsAlignment:
                                            MainAxisAlignment.center,
                                      );
                                    });
                              },
                              child: Column(children: [
                                Text(
                                  '${dateFormatter(DateTime.fromMillisecondsSinceEpoch((today.keyDate) * Duration.millisecondsPerDay), opt: 2)}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                RadialChart(
                                    chartData: chartData,
                                    pointsData: todayPoints),
                              ]),
                            ));
                      // : Card(
                      //     child: ListTile(
                      //     title: Text(
                      //         '${dateFormatter(DateTime.fromMillisecondsSinceEpoch((fitbit[fitbit.length - 1].keyDate) * Duration.millisecondsPerDay))}'),
                      //     subtitle: Text('$todayPoints'),
                      //   ));
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            }),
            // Text('SUMMARY of  DAYS'),
            Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
              return FutureBuilder(
                  initialData: null,
                  future: dbr.findAllFitbitData(),
                  //future: dbr.findAllSleepData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final fitbit = snapshot.data as List<myFitbitData>;
                      final double score = computeTotalPoints(fitbit);
                      // for (int i = 0; i < fitbit.length; i++) {
                      //   score += elaboratePoints(fitbit[i])
                      //       .fold(0, (prev, element) => prev + element);
                      // }
                      final List total = computeSum(fitbit);
                      print(total);
                      print(score.toStringAsFixed(2));

                      // List<charts.Series<DailyScore, String>> chartData =
                      //     createBarData(fitbit);
                      return fitbit.length == 0
                          ? Text('The list is currently empty')
                          : Column(
                              //height:250,
                              children: [
                                  Text(
                                      'SUMMARY of ${fitbit.length} DAYS: ${score.toStringAsFixed(2)} POINTS'),
                                  Container(
                                      height: 300,
                                      child: StackedBarChart(
                                          createBarData(fitbit)))
                                ]);

                      // : Expanded(
                      //     child: ListView.builder(
                      //       //itemCount: fitbit.length,
                      //       itemCount: 1,
                      //       itemBuilder: (context, index) {
                      //         return Card(
                      //             elevation: 3,
                      //             child: ListTile(
                      //               isThreeLine: true,
                      //               leading: Icon(MdiIcons.note),
                      //               // title: Text(
                      //               //     '${dateFormatter(fitbit[index].date)}'),
                      //               title: Text(
                      //                   'SUMMARY of ${fitbit.length} DAYS'),
                      //               // subtitle: Text(
                      //               //     'Sleep: ${fitbit[index].sleepHours}, Calories: ${fitbit[index].calories}, Steps: ${fitbit[index].steps}, Minutes Cardio: ${fitbit[index].cardio}'),
                      //               subtitle: Text(
                      //                   'Sleep: ${total[0]}, Calories:${total[1]}, Steps: ${total[2]}, Minutes Cardio: ${total[3]},'),
                      //               // onTap: () async {
                      //               //   await Provider.of<DatabaseRepository>(
                      //               //           context,
                      //               //           listen: false)
                      //               //       .deleteSleepData(data[index]);
                      //               // }
                      //             ));
                      //       },
                      //     ),
                      //   );
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            }),
          ]),
        )
            //),
            ));
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

double computeTotalPoints(List<myFitbitData> input) {
  double score = 0;
  for (int i = 0; i < input.length; i++) {
    score +=
        elaboratePoints(input[i]).fold(0, (prev, element) => prev + element);
  }
  return double.parse(score.toStringAsFixed(2));
}
