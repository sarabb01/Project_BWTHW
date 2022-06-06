import 'package:floor/floor.dart';

// TABLE STRUCTURE
//     Table Name : Users Credentials
// ID(int) USERNAME(String) PASSWORD(String)
@entity
class UsersCredentials {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String username;
  final String password;
  UsersCredentials(this.id, this.username, this.password);
}

// TABLE STRUCTURE
//     Table Name : SleepData
// ID(int) Data del sonno(date) Ore di sonno(int)

@entity
class myFitbitData {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final DateTime date;
  final int sleepHours;
  final int calories;
  final int steps;
  final int cardio;

  myFitbitData(this.id, this.date,
      {required this.sleepHours,
      required this.calories,
      required this.steps,
      required this.cardio});
}

@entity
class SleepData {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  //
  final DateTime date;
  final int sleepHours;

  SleepData(this.id, this.date, this.sleepHours);
}

// TABLE STRUCTURE
//     Table Name : Activity Data
// ID(int) Data dell'attivià(date) Calorie bruciate(int)

@entity
class ActivityData {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final DateTime date;
  final int calories;
  ActivityData(this.id, this.date, this.calories);
}

// TABLE STRUCTURE
//     Table Name : Steps Data
// ID(int) Data dei passi(date) Numero passi(int)

@entity
class StepsData {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final DateTime date;
  final int steps;
  StepsData(this.id, this.date, this.steps);
}

// TABLE STRUCTURE
//     Table Name : Heart Data
// ID(int) Data dell'attivià(date) Minuti in fascia cardio(int)

@entity
class HeartData {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final DateTime date;
  final int cardio;
  HeartData(this.id, this.date, this.cardio);
}
