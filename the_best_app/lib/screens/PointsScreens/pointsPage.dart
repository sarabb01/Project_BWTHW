// Flutter packages
import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:colours/colours.dart';
import 'package:floor/floor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

// Screens
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/Screens/PointsScreens/summaryPage.dart';

//Functions
import 'package:the_best_app/Functions/createChartdata.dart';
import 'package:the_best_app/Functions/dateFormatter.dart';
import 'package:the_best_app/Functions/elaborateDataFunctions.dart';
import 'package:the_best_app/Functions/fetchData.dart';
import 'package:the_best_app/Functions/findTarget.dart';

// Widgets and models
import 'package:the_best_app/Utils/radial_chart.dart';
import 'package:the_best_app/Utils/bar_chart.dart';
import 'package:the_best_app/Utils/legends.dart';
import 'package:the_best_app/Utils/formats.dart';
import 'package:the_best_app/models/targetTypes.dart';

// Database
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Repository/database_repository.dart';

class PointsPage extends StatelessWidget {
  static const route = '/hellowordpage/loginpage/homepage/pointspage';
  static const routename = 'Points Page';
  String username;

  PointsPage({required this.username});

  @override
  Widget build(BuildContext context) {
    print('${PointsPage.routename} built');
    return Scaffold(
        appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(CircleBorder()),
                      padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                      backgroundColor: MaterialStateProperty.all(
                          Colours.darkSeagreen), // <-- Button color
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.white38; // <-- Splash color
                      })),
                  child: Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushNamed(context, HomePage.route);
                  }),
            ),
            title: Text(PointsPage.routename),
            actions: [
              Row(
                children: [
                  IconButton(
                      // This button fetches data!
                      iconSize: 40,
                      tooltip: 'Update',
                      color: Colors.green[100],
                      onPressed: () async {
                        fetchData(context);
                        List<myFitbitData> allData =
                            await Provider.of<UsersDatabaseRepo>(context,
                                    listen: false)
                                .findAllFitbitDataUser(username);
                        final trg = await findTarget(context, username)
                            .then((String target) {
                          return target;
                        });
                        final double score = computeTotalPoints(allData, trg);
                      },
                      icon: Icon(Icons.update)),
                  IconButton(
                      // This button gets information!
                      iconSize: 40,
                      tooltip: 'Info',
                      icon: Icon(Icons.info),
                      color: Colors.green[100],
                      onPressed: () {
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
                      }),
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
                  future: Future.wait([
                    dbr.findAllFitbitDataUser(username),
                    findTarget(context, username)
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List<Object>;
                      final fitbit = data[0] as List<myFitbitData>;
                      final target = data[1] as String;

                      if (fitbit.length > 0) {
                        final today = fitbit[fitbit.length - 1];
                        final todayPoints = elaboratePoints(today, target);
                        // QUI CI VUOLE ELABORAZIONE PERCENTUALI
                        final List<CircularStackEntry> chartData =
                            createChartData(today, target);
                        final List values = Target().targets[target]!;

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
                                                'Steps: ${today.steps}/${values[0]} (${(todayPoints[0]).toStringAsFixed(2)})',
                                                style: TextStyle(
                                                    color: Colors.blue[600],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  'Calories: ${today.calories}/${values[1]}  (${(todayPoints[1]).toStringAsFixed(2)})',
                                                  style: TextStyle(
                                                      color: Colors.yellow[700],
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  'Minutes cardio: ${today.cardio}/${values[2]} (${(todayPoints[2]).toStringAsFixed(2)})',
                                                  style: TextStyle(
                                                      color: Colors.green[500],
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  'Sleep:  ${today.sleepHours}/${values[3]} (${(todayPoints[3]).toStringAsFixed(2)})',
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
                                          actions: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
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
                      // return CircularProgressIndicator();
                      return RadialChart(chartData: [
                        CircularStackEntry([
                          CircularSegmentEntry(100.0, Colors.grey,
                              rankKey: 'Empty'),
                          CircularSegmentEntry(0.0, Colors.grey)
                        ])
                      ], pointsData: [
                        0.0
                      ]);
                    }
                  });
            }),
            Legend_rad(),
            SizedBox(height: 15),
            Divider(color: Colors.black),
            Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
              return FutureBuilder(
                  initialData: null,
                  future: Future.wait([
                    dbr.findAllFitbitDataUser(username),
                    findTarget(context, username)
                  ]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List<Object>;
                      final fitbit = data[0] as List<myFitbitData>;
                      final target = data[1] as String;
                      if (fitbit.length > 0) {
                        final double score = computeTotalPoints(fitbit, target);

                        final List total = computeSum(fitbit);
                        //print(total);
                        //print(score.toStringAsFixed(2));
                        return fitbit.length == 0
                            ? Text('The list is currently empty')
                            : Column(
                                //height:250,
                                children: [
                                    Text('SUMMARY of ${fitbit.length} DAYS'),
                                    //  ${score.toStringAsFixed(2)} POINTS'),
                                    GestureDetector(
                                      onDoubleTap: () {
                                        Navigator.pushNamed(
                                            context, SummaryPage.route,
                                            arguments: {'username': username});
                                      },
                                      child: Container(
                                          height: 300,
                                          child: StackedBarChart(
                                              createBarData(fitbit, target))),
                                    )
                                  ]);
                      } else {
                        return Text('No data');
                      }
                    } else {
                      return Text('');
                      //CircularProgressIndicator();
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

// This function computes the total of each variable (not used here, but could be useful)
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
