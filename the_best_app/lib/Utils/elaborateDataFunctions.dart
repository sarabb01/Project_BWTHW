import 'package:flutter/cupertino.dart';
import 'package:fitbitter/fitbitter.dart';

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
