import 'package:floor/floor.dart';

//      TABLE STRUCTURE
//  Table Name :
//            myFitbitData
//  Attributes :
//            keyDate(int,Primary Key) - days (since epoch) of the data recording
//            sleepHours(int) - number of hours sleeping (rounded if >30 min)
//            calories(int) - active calories (NO BMR)
//            steps(int) - number of steps per day
//            cardio(int) - minutes in cardio range (133-161)
//            detailDate(int) - minutes (sinche epoch) of the recording --> needed to discriminate whether to update or not
//            username(String) - username of the person

@entity
class myFitbitData {
  @PrimaryKey(autoGenerate: false)
  final int keyDate; // Date of recording
  final int sleepHours;
  final int calories;
  final int steps;
  final int cardio;
  final int detailDate;
  final String username;
  myFitbitData(this.keyDate,
      {required this.sleepHours,
      required this.calories,
      required this.steps,
      required this.cardio,
      required this.detailDate,
      required this.username});
}
