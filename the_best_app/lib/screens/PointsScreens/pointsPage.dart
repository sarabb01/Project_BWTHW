//PACKAGES
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:colours/colours.dart';
import 'package:floor/floor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_best_app/Utils/legends.dart';

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
import 'package:the_best_app/models/pointsModel.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/Screens/PointsScreens/summaryPage.dart';

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
            leading: IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.route);
                }),
            title: Text(PointsPage.routename),
            actions: [
              Row(
                children: [
                  Consumer<PointsModel>(builder: (context, totscore, child) {
                    return IconButton(
                        // Questo bottone serve per avere le informazioni!!
                        iconSize: 40,
                        tooltip: 'Info',
                        icon: Icon(Icons.info),
                        color: Colors.green[100],
                        onPressed: () {
                          // List<myFitbitData> allData =
                          //     await Provider.of<UsersDatabaseRepo>(context,
                          //             listen: false)
                          //         .findAllFitbitData();
                          //
                          // final double score = computeTotalPoints(allData);
                          // print('${allData.length}, ${sp.getDouble('Points')}');

                          // totscore.updateScore(score);

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: SingleChildScrollView(
                                        child: ListBody(children: [
                                  Text(
                                      '-To see further information, double tap on the graph\n\n-To refresh data click on the REFRESH button top right')
                                ])));
                              });
                        });
                  }),
                  Consumer<PointsModel>(builder: (context, totscore, child) {
                    return IconButton(
                        // Questo bottone serve per fetchare!!
                        onPressed: () async {
                          fetchData(context);
                          List<myFitbitData> allData =
                              await Provider.of<UsersDatabaseRepo>(context,
                                      listen: false)
                                  .findAllFitbitData();
                          final double score = computeTotalPoints(allData);
                          totscore.updateScore(score);
                        },
                        icon: Icon(Icons.update));
                  })
                ],
              )
            ]),
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

                      //print(
                      //    '${dateFormatter(DateTime.fromMillisecondsSinceEpoch((fitbit[fitbit.length - 1].keyDate) * Duration.millisecondsPerDay))}');
                      if (fitbit.length > 0) {
                        final today = fitbit[fitbit.length - 1];
                        final todayPoints = elaboratePoints(today);
                        // QUI CI VUOLE ELABORAZIONE PERCENTUALI
                        final List<CircularStackEntry> chartData =
                            createChartData(today);

                        return fitbit.length == 0
                            ? Text('No activity recorded today')
                            : Container(
                                child: GestureDetector(
                                onDoubleTap: () {
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
                                              color: Colors.black,
                                              fontSize: 20),
                                          content: SingleChildScrollView(
                                            child: ListBody(children: [
                                              Text(
                                                'Steps ${(todayPoints[0] * 100).toStringAsFixed(1)}% (${today.steps} / 10000)',
                                                style: TextStyle(
                                                    color: Colors.blue[600],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  'Calories ${todayPoints[1] * 100}% (${today.calories} / 600)',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .yellowAccent[700],
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  'Cardio ${todayPoints[2] * 100}% (${today.cardio} / 15)',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .greenAccent[400],
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  'Sleep ${(todayPoints[3] * 100).toStringAsFixed(1)}% (${today.sleepHours} / 7)',
                                                  style: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ]),
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
                      } else {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${dateFormatter(DateTime.now(), opt: 2)}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text('No points gained yet',
                                  textAlign: TextAlign.center),
                              RadialChart(chartData: [
                                CircularStackEntry([
                                  CircularSegmentEntry(100.0, Colors.grey,
                                      rankKey: 'Empty'),
                                  CircularSegmentEntry(0.0, Colors.grey)
                                ])
                              ], pointsData: [
                                0.0
                              ])
                            ]);
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            }),
            // SizedBox(height: 5),
            Legend_rad(),
            SizedBox(height: 15),
            Divider(color: Colors.black),
            // Text('SUMMARY of  DAYS'),
            Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
              return FutureBuilder(
                  initialData: null,
                  future: dbr.findAllFitbitData(),
                  //future: dbr.findAllSleepData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final fitbit = snapshot.data as List<myFitbitData>;
                      if (fitbit.length > 0) {
                        final double score = computeTotalPoints(fitbit);

                        final List total = computeSum(fitbit);
                        //print(total);
                        //print(score.toStringAsFixed(2));
                        return fitbit.length == 0
                            ? Text('The list is currently empty')
                            : Column(
                                //height:250,
                                children: [
                                    Text(
                                        'SUMMARY of ${fitbit.length} DAYS: ${score.toStringAsFixed(2)} POINTS'),
                                    GestureDetector(
                                      onDoubleTap: () {
                                        Navigator.pushNamed(
                                            context, SummaryPage.route);
                                      },
                                      child: Container(
                                          height: 300,
                                          child: StackedBarChart(
                                              createBarData(fitbit))),
                                    )
                                  ]);
                      } else {
                        return Text('No data');
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  });
            }),
            SizedBox(height: 10),
            Legend_bar()
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

// double computeTotalPoints(List<myFitbitData> input) {
//   double score = 0;
//   for (int i = 0; i < input.length; i++) {
//     score +=
//         elaboratePoints(input[i]).fold(0, (prev, element) => prev + element);
//   }
//   return double.parse(score.toStringAsFixed(2));
// }
