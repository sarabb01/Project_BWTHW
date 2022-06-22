import 'package:flutter/cupertino.dart';
import 'package:fitbitter/fitbitter.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';

//https://www.verywellfit.com/target-heart-rate-calculator-3878160
//https://blog.fitbit.com/heart-rate-zones/

int elaborateSleepData(List<FitbitSleepData> result) {
  DateTime? endTime = result[result.length - 1].entryDateTime;
  DateTime? startTime = result[0].entryDateTime;
  int sleepDurHours = endTime!.difference(startTime!).inMinutes ~/ 60;
  final sleepDurMins = endTime.difference(startTime).inMinutes % 60;
  //print('${startTime} $sleepDurHours HOURS and $sleepDurMins MINUTES');
  if (sleepDurMins > 30) {
    ++sleepDurHours;
  }
  //downloads['${result[0].entryDateTime}'] = sleepDurHours;
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
  //downloads['${result[0].dateOfMonitoring}'] = totCal;
}

int elaborateTSActivityData(List<FitbitActivityTimeseriesData> result) {
  int totSteps = result[0].value!.round();
  //print('ACTIVITY: ${result[0].type}\n TOTAL: $totSteps');
  // print('$j: ${resultActivity[j]}');
  //downloads['${result[0].dateOfMonitoring}'] = totSteps;
  return totSteps;
}

int elaborateTSCalories(List<FitbitActivityTimeseriesData> result) {
  int totCals = result[0].value!.round();
  //print('ACTIVITY: ${result[0].type}\n TOTAL: $totSteps');
  // print('$j: ${resultActivity[j]}');
  //downloads['${result[0].dateOfMonitoring}'] = totSteps;
  return totCals;
}

int elaborateTSActiveCalories(List<FitbitActivityTimeseriesData> result) {
  int totCalsAct = result[0].value!.round();
  //print('ACTIVITY: ${result[0].type}\n TOTAL: $totSteps');
  // print('$j: ${resultActivity[j]}');
  //downloads['${result[0].dateOfMonitoring}'] = totSteps;
  return totCalsAct;
}

int elaborateHRData(List<FitbitHeartData> result) {
  int minCardio = 0;
  for (int j = 0; j < result.length; j++) {
    minCardio += result[j].minutesCardio!;
    //print('On date: ${result[j].dateOfMonitoring}\nMinutes in cardio range: ${result[j].minutesCardio}');
  }
  //print('Total minutes in cardio range: $minCardio');
  return minCardio;
  //downloads['${result[6].dateOfMonitoring}'] = minCardio;
}

List<double> elaboratePoints(myFitbitData data) {
  List<double> result = [];
  List<String> result2 = ['Steps', 'Calories', 'Minutes cardio', 'Sleep'];
  result.add(double.parse((data.steps / 10000).toStringAsFixed(2)));
  result.add(double.parse((data.calories / 600).toStringAsFixed(2)));
  result.add(double.parse((data.cardio / 15).toStringAsFixed(2)));
  result.add(double.parse((data.sleepHours / 7).toStringAsFixed(2)));
  //print(result);
  return result;
}

double computeTotalPoints(List<myFitbitData> input) {
  double score = 0;
  for (int i = 0; i < input.length; i++) {
    score +=
        elaboratePoints(input[i]).fold(0, (prev, element) => prev + element);
  }
  return double.parse(score.toStringAsFixed(2));
}
