import 'package:floor/floor.dart';

// TABLE STRUCTURE
//     Table Name : myFitbitData

@entity
class myFitbitData {
  //   @PrimaryKey(autoGenerate: true)
  // final int? id;
  @PrimaryKey(autoGenerate: false)
  final int keyDate;

  //final DateTime date;
  final int sleepHours;
  final int calories;
  final int steps;
  final int cardio;
  final int detailDate;

  myFitbitData(this.keyDate,
      /* this.date,*/
      {required this.sleepHours,
      required this.calories,
      required this.steps,
      required this.cardio,
      required this.detailDate});
}
