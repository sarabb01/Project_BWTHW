// Flutter packages
import 'package:flutter/cupertino.dart';
import 'package:fitbitter/fitbitter.dart';

// Database
import 'package:the_best_app/Database/Entities/FitbitTables.dart';

// Models
import 'package:the_best_app/models/targetTypes.dart';

//https://www.verywellfit.com/target-heart-rate-calculator-3878160
//https://blog.fitbit.com/heart-rate-zones/

/*
Function Description:
These functions take lists of FitbitData and elaborate them depending on their type.
In general, they return an 'int' representing the quantity of the relative fitbit data
*/

int elaborateSleepData(List<FitbitSleepData> result) {
  DateTime? endTime = result[result.length - 1].entryDateTime;
  DateTime? startTime = result[0].entryDateTime;
  int sleepDurHours = endTime!.difference(startTime!).inMinutes ~/ 60;
  final sleepDurMins = endTime.difference(startTime).inMinutes % 60;
  //print('${startTime} $sleepDurHours HOURS and $sleepDurMins MINUTES');
  if (sleepDurMins > 30) {
    ++sleepDurHours;
  }
  return sleepDurHours;
}

int elaborateActivityData(List<FitbitActivityData> result) {
  int totCal = 0;
  for (int j = 0; j < result.length; j++) {
    int minActivity = result[j].duration! ~/ 60000;
    //print('ACTIVITY: ${result[j].name}\n MIN: $minActivity\n CALORIES: ${result[j].calories}');
    // print('$j: ${resultActivity[j]}');
    totCal = totCal + result[j].calories!.round();
  }
  return totCal;
}

int elaborateTSActivityData(List<FitbitActivityTimeseriesData> result) {
  int totSteps = result[0].value!.round();
  //print('ACTIVITY: ${result[0].type}\n TOTAL: $totSteps');
  // print('$j: ${resultActivity[j]}');
  return totSteps;
}

int elaborateTSCalories(List<FitbitActivityTimeseriesData> result) {
  int totCals = result[0].value!.round();
  //print('ACTIVITY: ${result[0].type}\n TOTAL: $totSteps');
  // print('$j: ${resultActivity[j]}');
  return totCals;
}

int elaborateTSActiveCalories(List<FitbitActivityTimeseriesData> result) {
  int totCalsAct = result[0].value!.round();
  //print('ACTIVITY: ${result[0].type}\n TOTAL: $totSteps');
  // print('$j: ${resultActivity[j]}');
  return totCalsAct;
}

int elaborateHRData(List<FitbitHeartData> result) {
  int minCardio = 0;
  for (int j = 0; j < result.length; j++) {
    minCardio += result[j].minutesCardio!;
  }
  //print('Total minutes in cardio range: $minCardio');
  return minCardio;
}

/*
Function Description:
This function takes a single entry of the FitbitTable and computes the points relative to that entry(date).
Points are calculated as percentage of the target of each category and then summed up
*/

List<double> elaboratePoints(myFitbitData data, String target) {
  List<double> result = [];
  List<String> result2 = ['Steps', 'Calories', 'Minutes cardio', 'Sleep'];
  final Target values = Target();
  final int steps = values.targets[target]![0];
  final int cals = values.targets[target]![1];
  final int cardio = values.targets[target]![2];
  final int sleep = values.targets[target]![3];

  result.add(double.parse((data.steps / steps).toStringAsFixed(2)));
  result.add(double.parse((data.calories / cals).toStringAsFixed(2)));
  result.add(double.parse((data.cardio / cardio).toStringAsFixed(2)));
  result.add(double.parse((data.sleepHours / sleep).toStringAsFixed(2)));
  //print(result);
  if (target == 'Medium') {
    var result1 = result.map((e) => e * 1.2).toList();
    return result1;
  }
  if (target == 'Advanced') {
    var result1 = result.map((e) => e * 1.5).toList();
    return result1;
  }

  if (target == 'None') {
    var result1 = result.map((e) => e * 0.8).toList();
    return result1;
  }
  return result;
}

/*
Function Description:
This function just computes the sum of the points of each category
*/

double computeTotalPoints(List<myFitbitData> input, String target) {
  double score = 0;
  for (int i = 0; i < input.length; i++) {
    score += elaboratePoints(input[i], target)
        .fold(0, (prev, element) => prev + element);
  }
  return double.parse(score.toStringAsFixed(2));
}
