import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Utils/stringsKeywords.dart';
import 'package:the_best_app/functions/dateFormatter.dart';
import 'package:the_best_app/functions/elaborateDataFunctions.dart';
import 'package:the_best_app/models/fitbitDataTypes.dart';

Future<void> fetchData(BuildContext context) async {
  List<myFitbitData> allData =
      await Provider.of<UsersDatabaseRepo>(context, listen: false)
          .findAllFitbitData();
  final fitbit2 = allData.reversed.toList();

  int threshold = 6;
  if (fitbit2.length > 0) {
    DateTime lastInsertion = myDate(fitbit2[fitbit2.length - 1].detailDate);
    int intlastInsertion = (fitbit2[fitbit2.length - 1].detailDate);
    int threshold =
        (DateTime.now().millisecondsSinceEpoch ~/ 60000) - intlastInsertion;
    print(intlastInsertion);
  }
  //debug
  // print(threshold);
  // print(DateTime.now().millisecondsSinceEpoch ~/ 60000);

  // print(allData[allData.length - 1].keyDate);
  //print(threshold);

  DateTime startDate = DateTime.utc(2022, 5, 15);
  //DateTime endDate = DateTime.utc(2022, 5, 25);
  DateTime endDate = DateTime.now();

  int daysToSubtract =
      // DateTime.now().difference(DateTime.utc(2022, 6, 8, 1, 1, 1, 1, 1)).inDays;
      endDate.difference(startDate).inDays;
  print('N of calls $daysToSubtract');
  print(endDate);

  // List<FitbitSleepData>? result;
  // List<FitbitActivityData> resultActivity;
  // List<FitbitActivityTimeseriesData> resultTSActivity;
  // List<FitbitHeartData> resultHR;

  // late List<FitbitSleepData> result;
  // late List<FitbitActivityData> resultActivity;
  // late List<FitbitActivityTimeseriesData> resultTSActivity;
  // late List<FitbitHeartData> resultHR;

  if (threshold > 5) {
    for (int reqDay = daysToSubtract; reqDay >= 0; reqDay--) {
      //for (int reqDay = 10; reqDay >= 8; reqDay--) {
      //int reqDay = 1;
      DateTime queryDate = endDate.subtract(Duration(days: reqDay));
      int detail = queryDate.millisecondsSinceEpoch ~/
          60000; //MILLISECONDS IN A MINUTE --> NUMBER OF MINUTES SINCHE EPOCH
      int tableKey = queryDate.millisecondsSinceEpoch ~/
          86400000; // MILLISECONDS IN A DAY --> NUMBER OF DAYS SINCE EPOCH.

      print('Query date: $queryDate');
      print('INT: $tableKey, DETAIL: $detail');
      try {
        final result = await fetchSleepData(queryDate) as List<FitbitSleepData>;
        final resultActivity =
            await fetchActivityData(queryDate) as List<FitbitActivityData>;
        final resultTSActivity = await fetchActivityTSData(queryDate, 'steps')
            as List<FitbitActivityTimeseriesData>;
        final resultHR =
            await fetchHeartData(queryDate) as List<FitbitHeartData>;

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
      } catch (FitbitRateLimitExceededException) {
        print('Catch error');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'YOU HAVE TO WAIT!',
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red));
        break;
      }
      // final result = await fetchSleepData(queryDate) as List<FitbitSleepData>;
      // final resultActivity =
      //     await fetchActivityData(queryDate) as List<FitbitActivityData>;
      // final resultTSActivity = await fetchActivityTSData(queryDate, 'steps')
      //     as List<FitbitActivityTimeseriesData>;
      // final resultHR = await fetchHeartData(queryDate) as List<FitbitHeartData>;

      // int time = 0;
      // int cals = 0;
      // int steps = 0;
      // int mins = 0;

      // if (result.length > 0) {
      //   time = elaborateSleepData(result);
      // }
      // //print('Current time $time');

      // if (resultActivity.length > 0) {
      //   cals = elaborateActivityData(resultActivity);
      // }
      // //print('Current cals $cals');

      // if (resultTSActivity.length > 0) {
      //   steps = elaborateTSActivityData(resultTSActivity);
      // }
      // //print('Current cals $steps');

      // if (resultHR.length > 0) {
      //   mins = elaborateHRData(resultHR);
      // }
      // //print('Current min $mins');
      // myFitbitData newdata = myFitbitData(tableKey,
      //     sleepHours: time,
      //     calories: cals,
      //     steps: steps,
      //     cardio: mins,
      //     detailDate: detail);
      // await Provider.of<UsersDatabaseRepo>(context, listen: false)
      //     .insertFitbitData(newdata);
    }
  } else {
    print('Data alreay updated');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          '\nData alreay updated\n',
          style: TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.yellow));
  }
}

///////////////////////////
///
DateTime myDate(int date) {
  return DateTime.fromMillisecondsSinceEpoch(
      date * Duration.millisecondsPerMinute);
}

Future fetchActivityData(DateTime reqDay) async {
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

Future fetchActivityTSData(DateTime reqDay, String Type) async {
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

Future fetchHeartData(DateTime reqDay) async {
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

Future fetchSleepData(DateTime reqDay) async {
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
