import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Utils/stringsKeywords.dart';
import 'package:the_best_app/functions/elaborateDataFunctions.dart';

Future<void> fetchData(BuildContext context) async {
  DateTime startDate = DateTime.utc(2022, 4, 10);
  DateTime endDate = DateTime.utc(2022, 4, 14);
  int daysToSubtract =
      // DateTime.now().difference(DateTime.utc(2022, 6, 8, 1, 1, 1, 1, 1)).inDays;
      endDate.difference(startDate).inDays;
  print('N of calls $daysToSubtract');

  // late List<SleepData> result;
  // late List<ActivityData> resultActivity;
  // late List<StepsData> resultTSActivity;
  // late List<HeartData> resultHR;
  for (int reqDay = daysToSubtract; reqDay >= 0; reqDay--) {
    //for (int reqDay = 10; reqDay >= 8; reqDay--) {
    //int reqDay = 1;
    DateTime queryDate = endDate.subtract(Duration(days: reqDay));
    int tableKey = queryDate.millisecondsSinceEpoch ~/ 86400000;
    print('Query date: $queryDate');
    print('INT: $tableKey');
    final result = await fetchSleepData(queryDate) as List<FitbitSleepData>;
    final resultActivity =
        await fetchActivityData(queryDate) as List<FitbitActivityData>;
    final resultTSActivity = await fetchActivityTSData(queryDate, 'steps')
        as List<FitbitActivityTimeseriesData>;
    final resultHR = await fetchHeartData(queryDate) as List<FitbitHeartData>;

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
        sleepHours: time, calories: cals, steps: steps, cardio: mins);
    await Provider.of<UsersDatabaseRepo>(context, listen: false)
        .insertFitbitData(newdata);
  }
}

///////////////////////////

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
