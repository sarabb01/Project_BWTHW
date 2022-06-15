//Import Packages
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';

//Import DB things
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Database/typeConverters/dateTimeConverter.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/models/fitbitDataTypes.dart';
//Import Screens
import 'package:the_best_app/screens/PointsScreens/pointsPage.dart';

//Import Functions and Useful things
import 'package:the_best_app/functions/dateFormatter.dart';
import 'package:the_best_app/functions/elaborateDataFunctions.dart';
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
    DateTime startDate = DateTime.utc(2022, 6, 13);
    //DateTime endDate = DateTime.utc(2022, 5, 31);
    DateTime endDate = DateTime.now();
    int daysToSubtract =
        // DateTime.now().difference(DateTime.utc(2022, 6, 8, 1, 1, 1, 1, 1)).inDays;
        endDate.difference(startDate).inDays;

    // List<SleepData>? result;
    // List<ActivityData>? resultActivity;
    // List<StepsData>? resultTSActivity;
    // List<HeartData>? resultHR;

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
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  print('N of calls $daysToSubtract');
                  for (int reqDay = daysToSubtract; reqDay >= 0; reqDay--) {
                    //for (int reqDay = 10; reqDay >= 8; reqDay--) {
                    //int reqDay = 1;
                    // DateTime queryDate =
                    //     DateTime.now().subtract(Duration(days: reqDay));
                    DateTime queryDate =
                        endDate.subtract(Duration(days: reqDay));
                    int detail = queryDate.millisecondsSinceEpoch ~/ 60000;
                    int tableKey = queryDate.millisecondsSinceEpoch ~/ 86400000;
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
                        cardio: mins,
                        detailDate: detail);
                    await Provider.of<UsersDatabaseRepo>(context, listen: false)
                        .insertFitbitData(newdata);
                  }
                },
                child: Text('Fetch Data')),
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
