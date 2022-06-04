import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

import 'package:the_best_app/Utils/dateFormatter.dart';
import 'package:the_best_app/Utils/stringsKeywords.dart';

class FetchPage extends StatefulWidget {
  FetchPage({Key? key}) : super(key: key);

  static const route = 'home/auth/fetchdata';
  static const routename = 'FetchPage';

  @override
  _FetchPageState createState() => _FetchPageState();
}

class _FetchPageState extends State<FetchPage> {
  @override
  Widget build(BuildContext context) {
    print('${FetchPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(FetchPage.routename),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_circle_right),
            onPressed: () {
              //Navigator.pushNamed(context, PointsPage.route);
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
                    future: _fetchAccountData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data as List;
                        FitbitAccountData dataUser =
                            data[0] as FitbitAccountData;

                        return Text(
                            '${dataUser.firstName} \'s birthday: ${dateFormatter(dataUser.dateOfBirth!)}');
                      } else {
                        return CircularProgressIndicator();
                      }
                      ;
                    })),
            // SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('${_downloads.values}'),
            // ),
            // ElevatedButton(
            //     onPressed: () async {
            //       for (int i = 54; i >= 50; i--) {
            //         print(i);
            //         final result =
            //             await _fetchSleepData(i) as List<FitbitSleepData>;
            //         if (result.length > 0) {
            //           int mins = elaborateData(result, _downloads);
            //           setState(() {});
            //           // setState(() {
            //           //   if (sleepDurMins > 30) {
            //           //     ++sleepDurHours;
            //           //   }
            //           //   _downloads['${result[0].entryDateTime}'] =
            //           //       sleepDurHours;
            //           // });
            //           SleepData newdata =
            //               SleepData(null, result[0].entryDateTime!, mins);
            //           await Provider.of<DatabaseRepository>(context,
            //                   listen: false)
            //               .insertSleepData(newdata);
            //         }
            //       }
            //     },
            //     child: Text('Fetch Sleep Data')),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('${_activities.values} ${_activities.keys}'),
            // ),
            // ElevatedButton(
            //     onPressed: () async {
            //       for (int i = 10; i >= 8; i--) {
            //         // print(i);
            //         final resultActivity =
            //             await _fetchActivityData(i) as List<FitbitActivityData>;
            //         if (resultActivity.length > 0) {
            //           elaborateDataActivity(resultActivity, activities);
            //           // }
            //           setState(() {});
            //         }
            //         ; // if
            //       } // for
            //       ;
            //     }, // onPressed
            //     child: Text('Fetch Activity Data')),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('${_activitiesTS.values}'),
            // ),
            // ElevatedButton(
            //     onPressed: () async {
            //       for (int i = 10; i >= 8; i--) {
            //         // print(i);
            //         //  //'calories', 'steps', 'distance', 'floors', 'minutesVeryActive', 'activityCalories',etc
            //         final resultTSActivity =
            //             await _fetchActivityTSData(i, 'steps')
            //                 as List<FitbitActivityTimeseriesData>;
            //         if (resultTSActivity.length > 0) {
            //           elaborateDataTSActivity(resultTSActivity, activitiesTS);
            //           // }
            //           setState(() {});
            //         }
            //         ; // if
            //       } // for
            //       ;
            //     }, // onPressed
            //     child: Text('Fetch Activity TS Data')),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('${_heart.values}'),
            // ),
            // ElevatedButton(
            //     onPressed: () async {
            //       final resultHR =
            //           await _fetchHeartData() as List<FitbitHeartData>;
            //       if (resultHR.length > 0) {
            //         elaborateDataHR(resultHR, heart);
            //         // }
            //         setState(() {});
            //       }
            //       // for
            //       ;
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

Future _fetchActivityData(int reqDay) async {
  // Activity Data
  FitbitActivityDataManager fitbitActivityDataManager =
      FitbitActivityDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );

  FitbitActivityAPIURL fitbitActivityApiUrl = FitbitActivityAPIURL.day(
    date: DateTime.now().subtract(Duration(days: reqDay)),
    userID: '7ML2XV',
  );

  return fitbitActivityDataManager.fetch(fitbitActivityApiUrl);
}

/////////////////

Future _fetchActivityTSData(int reqDay, String Type) async {
  // Activity Timeseries data
  FitbitActivityTimeseriesDataManager fitbitActivityTimeseriesDataManager =
      FitbitActivityTimeseriesDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
    type: Type,
  );

  FitbitActivityTimeseriesAPIURL fitbitActivityApiUrl =
      FitbitActivityTimeseriesAPIURL.dayWithResource(
    date: DateTime.now().subtract(Duration(days: reqDay)),
    userID: '7ML2XV',
    resource: fitbitActivityTimeseriesDataManager.type,
  );

  return fitbitActivityTimeseriesDataManager.fetch(fitbitActivityApiUrl);
}

////////////////////

Future _fetchHeartData() async {
  // Heart Data
  FitbitHeartDataManager fitbitHeartDataManager = FitbitHeartDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );

  FitbitHeartAPIURL fitbitHeartApiUrl = FitbitHeartAPIURL.weekWithUserID(
    baseDate: DateTime.now(),
    //date: DateTime.now().subtract(Duration(days: 5)),
    userID: '7ML2XV',
  );

  return fitbitHeartDataManager.fetch(fitbitHeartApiUrl);
}

////////////////////

Future _fetchSleepData(int reqDay) async {
  // Heart Data
  FitbitSleepDataManager fitbitSleepDataManager = FitbitSleepDataManager(
    clientID: Strings.fitbitClientID,
    clientSecret: Strings.fitbitClientSecret,
  );

  FitbitSleepAPIURL fitbitSleepApiUrl = FitbitSleepAPIURL.withUserIDAndDay(
    date: DateTime.now().subtract(Duration(days: reqDay)),
    //afterDate: DateTime(2022, 15, 10),
    userID: '7ML2XV',
    //limit: 10
  );

  return fitbitSleepDataManager.fetch(fitbitSleepApiUrl);
}
