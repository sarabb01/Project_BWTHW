//Import Packages
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

//Import DB things
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Database/typeConverters/dateTimeConverter.dart';
import 'package:the_best_app/Repository/database_repository.dart';
//Import Screens
import 'package:the_best_app/screens/PointsScreens/pointsPage.dart';

//Import Functions and Useful things
import 'package:the_best_app/Utils/dateFormatter.dart';
import 'package:the_best_app/Utils/elaborateDataFunctions.dart';
import 'package:the_best_app/Utils/stringsKeywords.dart';

class FetchPage extends StatefulWidget {
  FetchPage({Key? key}) : super(key: key);

  static const route = 'home/auth/fetchdata';
  static const routename = 'FetchPage';

  @override
  _FetchPageState createState() => _FetchPageState();
}

class _FetchPageState extends State<FetchPage> {
  int daysToSubtract =
      DateTime.now().difference(DateTime.utc(2022, 6, 6, 1, 1, 1, 1, 1)).inDays;

  @override
  Widget build(BuildContext context) {
    late List<SleepData> result;
    late List<ActivityData> resultActivity;
    late List<StepsData> resultTSActivity;
    late List<HeartData> resultHR;

    print('${FetchPage.routename} built');
    print(daysToSubtract);
    return Scaffold(
      appBar: AppBar(
        title: Text(FetchPage.routename),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_circle_right),
            onPressed: () {
              Navigator.pushNamed(context, PointsPage.route);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: FutureBuilder(
                    //future: FitbitConnector.isTokenValid() as Future,
                    future:
                        FitbitConnector.storage.read(key: 'fitbitAccessToken'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final token = snapshot.data;
                        //print('Token is............... ${token.runtimeType}');
                        if (token != null) {
                          return Text('Authorization succeded');
                        } else if (FitbitConnector.storage
                                .read(key: 'fitbitRefreshToken') !=
                            null) {
                          return Text('Authorization succeded');
                        } else {
                          return CircularProgressIndicator();
                        }
                        ;
                      } else {
                        return (Text(
                            'Authorization Denied!\nGo to Authorization'));
                      }
                    })),

            // Old Version
            // child: FutureBuilder(
            //     future: _fetchAccountData(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         final data = snapshot.data as List;
            //         FitbitAccountData dataUser =
            //             data[0] as FitbitAccountData;

            //         return Text(
            //             '${dataUser.firstName} \'s birthday: ${dateFormatter(dataUser.dateOfBirth!)}');
            //       } else {
            //         return CircularProgressIndicator();
            //       }
            //       ;
            //     })),
            SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('${_downloads.values}'),
            // ),
            ElevatedButton(
                onPressed: () async {
                  print('N of calls $daysToSubtract');
                  for (int reqDay = daysToSubtract; reqDay > 0; reqDay--) {
                    //for (int reqDay = 10; reqDay >= 8; reqDay--) {
                    //int reqDay = 1;
                    DateTime queryDate =
                        DateTime.now().subtract(Duration(days: reqDay));
                    int tableKey = queryDate.millisecondsSinceEpoch ~/ 86400000;
                    print(Duration.millisecondsPerDay);
                    print('Query date: $queryDate');
                    print('INT: $tableKey');
                    final result = await _fetchSleepData(queryDate)
                        as List<FitbitSleepData>;
                    final resultActivity = await _fetchActivityData(queryDate)
                        as List<FitbitActivityData>;
                    final resultTSActivity =
                        await _fetchActivityTSData(queryDate, 'steps')
                            as List<FitbitActivityTimeseriesData>;
                    final resultHR = await _fetchHeartData(queryDate)
                        as List<FitbitHeartData>;

                    int time = 0;
                    int cals = 0;
                    int steps = 0;
                    int mins = 0;

                    if (result.length > 0) {
                      time = elaborateSleepData(result);
                    }
                    //print('Current time $time');

                    if (resultActivity.length > 0) {
                      cals = elaborateActivityData(resultActivity);
                    }
                    //print('Current cals $cals');

                    if (resultTSActivity.length > 0) {
                      steps = elaborateTSActivityData(resultTSActivity);
                    }
                    //print('Current cals $steps');

                    if (resultHR.length > 0) {
                      mins = elaborateHRData(resultHR);
                    }
                    //print('Current min $mins');

                    myFitbitData newdata = myFitbitData(tableKey,
                        sleepHours: time,
                        calories: cals,
                        steps: steps,
                        cardio: mins);
                    await Provider.of<UsersDatabaseRepo>(context, listen: false)
                        .insertFitbitData(newdata);
                  }
                },
                child: Text('Fetch Data')),

            //   SleepData newdata = SleepData(null,
            //       result[0].entryDateTime!, elaborateSleepData(result));
            //   await Provider.of<UsersDatabaseRepo>(context,
            //           listen: false)
            //       .insertSleepData(newdata);
            // } else {
            //   SleepData newdata = SleepData(
            //       null,
            //       DateTime.utc(2022, 3, 1).add(Duration(days: reqDay)),
            //       0);
            //   await Provider.of<UsersDatabaseRepo>(context,
            //           listen: false)
            //       .insertSleepData(newdata);
            // }
            //     if (resultActivity.length > 0) {
            //       //int cals = elaborateActivityData(resultActivity);
            //       // int date = resultActivity[0]
            //       //     .dateOfMonitoring!
            //       //     .microsecondsSinceEpoch;
            //       ActivityData newdata = ActivityData(
            //           null,
            //           resultActivity[0].dateOfMonitoring!,
            //           elaborateActivityData(resultActivity));
            //       await Provider.of<UsersDatabaseRepo>(context,
            //               listen: false)
            //           .insertActivityData(newdata);
            //     }
            //     if (resultTSActivity.length > 0) {
            //       //int steps = elaborateTSActivityData(resultTSActivity);
            //       StepsData newdata = StepsData(
            //           null,
            //           resultTSActivity[0].dateOfMonitoring!,
            //           elaborateTSActivityData(resultTSActivity));
            //       await Provider.of<UsersDatabaseRepo>(context,
            //               listen: false)
            //           .insertStepsData(newdata);
            //     }
            //     if (resultHR.length > 0) {
            //       //int minCardio = elaborateHRData(resultHR);
            //       HeartData newdata = HeartData(
            //           null,
            //           resultHR[0].dateOfMonitoring!,
            //           elaborateHRData(resultHR));
            //       await Provider.of<UsersDatabaseRepo>(context,
            //               listen: false)
            //           .insertHeartData(newdata);
            //     }
            //   }
            //   ;
            // },
            // child: Text('Fetch Data')),

            // //Padding(
            // //   padding: const EdgeInsets.all(8.0),
            // //   child: Text('${_activities.values} ${_activities.keys}'),
            // // ),
            // ElevatedButton(
            //     onPressed: () async {
            //       for (int reqDay = daysToSubtract; reqDay > 1; reqDay--) {
            //         //for (int i = 10; i >= 8; i--) {
            //         // print(i);
            //         final resultActivity = await _fetchActivityData(reqDay)
            //             as List<FitbitActivityData>;
            //         if (resultActivity.length > 0) {
            //           int cals = elaborateActivityData(resultActivity);
            //           // }
            //           ActivityData newdata = ActivityData(
            //               null, resultActivity[0].dateOfMonitoring!, cals);
            //           await Provider.of<UsersDatabaseRepo>(context,
            //                   listen: false)
            //               .insertActivityData(newdata);
            //         }

            //         ; // if
            //       } // for
            //       ;
            //     }, // onPressed
            //     child: Text('Fetch Activity Data')),
            // // Padding(
            // //   padding: const EdgeInsets.all(8.0),
            // //   child: Text('${_activitiesTS.values}'),
            // // ),
            // ElevatedButton(
            //     onPressed: () async {
            //       for (int reqDay = daysToSubtract; reqDay > 1; reqDay--) {
            //         //for (int i = 10; i >= 8; i--) {
            //         // print(i);
            //         //  //'calories', 'steps', 'distance', 'floors', 'minutesVeryActive', 'activityCalories',etc
            //         final resultTSActivity =
            //             await _fetchActivityTSData(reqDay, 'steps')
            //                 as List<FitbitActivityTimeseriesData>;
            //         if (resultTSActivity.length > 0) {
            //           int steps = elaborateTSActivityData(resultTSActivity);
            //           // }
            //           //setState(() {});
            //           StepsData newdata = StepsData(
            //               null, resultTSActivity[0].dateOfMonitoring!, steps);
            //           await Provider.of<UsersDatabaseRepo>(context,
            //                   listen: false)
            //               .insertStepsData(newdata);
            //         }
            //         ; // if
            //       } // for
            //       ;
            //     }, // onPressed
            //     child: Text('Fetch Steps Data')),
            // // Padding(
            // //   padding: const EdgeInsets.all(8.0),
            // //   child: Text('${_heart.values}'),
            // // ),
            // ElevatedButton(
            //     onPressed: () async {
            //       for (int reqDay = daysToSubtract; reqDay > 1; reqDay--) {
            //         final resultHR =
            //             await _fetchHeartData(reqDay) as List<FitbitHeartData>;
            //         if (resultHR.length > 0) {
            //           int minCardio = elaborateHRData(resultHR);
            //           // }
            //           //setState(() {});
            //           HeartData newdata = HeartData(
            //               null, resultHR[0].dateOfMonitoring!, minCardio);
            //           await Provider.of<UsersDatabaseRepo>(context,
            //                   listen: false)
            //               .insertHeartData(newdata);
            //         }
            //         // for
            //         ;
            //       }
            //     }, // onPressed
            //     child: Text('Fetch Heart Data')),
          ],
        ),
      ),
    );
  }
} //HomePage

/////////////////
Future _fetchAccountData() async {
  // Activity Data
  FitbitAccountDataManager fitbitAccountDataManager = FitbitAccountDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );

  FitbitUserAPIURL fitbitUserApiUrl = FitbitUserAPIURL.withUserID(
    userID: '7ML2XV',
  );

  return fitbitAccountDataManager.fetch(fitbitUserApiUrl);
}

///////////////////////////

Future _fetchActivityData(DateTime reqDay) async {
  // Activity Data
  FitbitActivityDataManager fitbitActivityDataManager =
      FitbitActivityDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );

  FitbitActivityAPIURL fitbitActivityApiUrl = FitbitActivityAPIURL.day(
    // date: DateTime.now().subtract(Duration(days: reqDay)),
    date: reqDay,
    userID: '7ML2XV',
  );

  return fitbitActivityDataManager.fetch(fitbitActivityApiUrl);
}

/////////////////

Future _fetchActivityTSData(DateTime reqDay, String Type) async {
  // Activity Timeseries data
  FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
      FitbitActivityTimeseriesDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
    type: Type,
  );

  FitbitActivityTimeseriesAPIURL fitbitActivityApiUrl =
      FitbitActivityTimeseriesAPIURL.dayWithResource(
    // if you use week, you use less calls maybe!
    date: reqDay,
    // date: DateTime.now().subtract(Duration(days: reqDay)),
    userID: '7ML2XV',
    resource: fitbitActivityTimeseriesDataManager.type,
  );

  return fitbitActivityTimeseriesDataManager.fetch(fitbitActivityApiUrl);
}

////////////////////

Future _fetchHeartData(DateTime reqDay) async {
  // Heart Data
  FitbitHeartDataManager fitbitHeartDataManager = FitbitHeartDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );

  // FitbitHeartAPIURL fitbitHeartApiUrl = FitbitHeartAPIURL.weekWithUserID(
  //   baseDate: DateTime.now().subtract(Duration(days: reqDay)),
  FitbitHeartAPIURL fitbitHeartApiUrl = FitbitHeartAPIURL.dayWithUserID(
    date: reqDay,
    // date: DateTime.now().subtract(Duration(days: reqDay)),
    //date: DateTime.now().subtract(Duration(days: 5)),
    userID: '7ML2XV',
  );

  return fitbitHeartDataManager.fetch(fitbitHeartApiUrl);
}

////////////////////

Future _fetchSleepData(DateTime reqDay) async {
  // Heart Data
  FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );

  FitbitSleepAPIURL fitbitSleepApiUrl = FitbitSleepAPIURL.withUserIDAndDay(
    date: reqDay,
    // date: DateTime.now().subtract(Duration(days: reqDay)),
    //afterDate: DateTime(2022, 15, 10),
    userID: '7ML2XV',
    //limit: 10
  );

  return fitbitSleepDataManager.fetch(fitbitSleepApiUrl);
}
