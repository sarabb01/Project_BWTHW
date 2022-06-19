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

  DateTime lastInsertion = (allData.length > 0)
      ? myDate(allData[allData.length - 1].detailDate)
      : DateTime.utc(2022, 6, 17);

  // if (allData.length > 0) {
  //   DateTime lastInsertion = myDate(allData[allData.length - 1].detailDate);
  //   int intlastInsertion = (allData[allData.length - 1].detailDate);
  //   final threshold =
  //       (DateTime.now().millisecondsSinceEpoch ~/ 60000) - intlastInsertion;
  //   print('met1 $intlastInsertion');;
  // }

  print('Last insertion $lastInsertion');
  DateTime startDate = DateTime.utc(2022, 6, 10);
  //DateTime startDate = lastInsertion;
  //DateTime endDate = DateTime.utc(2022, 6, 10);
  DateTime endDate = DateTime.now();

  int threshold = calculateThreshold(allData, endDate);
  print('Threshold mins $threshold');

  int daysToSubtract =
      // DateTime.now().difference(DateTime.utc(2022, 6, 8, 1, 1, 1, 1, 1)).inDays;
      endDate.difference(startDate).inDays;

  print('N of calls $daysToSubtract');
  print(endDate);

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

        final resultBMRCal = await fetchActivityTSData(queryDate, 'caloriesBMR')
            as List<FitbitActivityTimeseriesData>;

        final resultHR =
            await fetchHeartData(queryDate) as List<FitbitHeartData>;

        int time = 0;
        int cals = 0;
        int activeCals = 0;
        int steps = 0;
        int mins = 0;

        if (result.length > 0) {
          time = elaborateSleepData(result);
        }
        //print('Current time $time');

        if (resultActivity.length > 0) {
          cals = elaborateActivityData(resultActivity);
          print('$queryDate Metodo 1 TOt: $cals');
        }
        //print('Current cals $cals');

        if (resultTSActivity.length > 0) {
          steps = elaborateTSActivityData(resultTSActivity);
        }
        //print('Current cals $steps');

        if (resultBMRCal.length > 0) {
          int bmrCals = elaborateTSCalories(resultBMRCal);
          print('BMR $bmrCals');
          int totCals = elaborateTSActiveCalories(
              await fetchActivityTSData(queryDate, 'calories')
                  as List<FitbitActivityTimeseriesData>);
          print('Active $totCals');
          print('$queryDate Metodi 2 TOT ${totCals - bmrCals}');
          activeCals = totCals - bmrCals;
        }

        if (resultHR.length > 0) {
          mins = elaborateHRData(resultHR);
        }

        cals = activeCals > 0 ? activeCals : cals;
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
        print('Catched error');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Too many requests! YOU HAVE TO WAIT!',
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red));
        break;
      }
    }
  } else {
    print('Data alreay updated');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Data alreay updated',
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

int calculateThreshold(List<myFitbitData> input, DateTime endDate) {
  if (input.length > 0) {
    DateTime lastInsertion = myDate(input[input.length - 1].detailDate);
    int intlastInsertion = (input[input.length - 1].detailDate);
    final threshold =
        (endDate.millisecondsSinceEpoch ~/ 60000) - intlastInsertion;
    return threshold;
  } else {
    final threshold = 6;
    return threshold;
  }
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
