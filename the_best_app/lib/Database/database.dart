//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:the_best_app/Database/typeConverters/dateTimeConverter.dart';

//Here, we are importing the entities and the daos of the database
import 'package:the_best_app/Database/Daos/activityDao.dart';
import 'package:the_best_app/Database/Daos/heartDao.dart';
import 'package:the_best_app/Database/Daos/sleepDao.dart';
import 'package:the_best_app/Database/Daos/stepsDao.dart';
import 'package:the_best_app/Database/Daos/UserCreddaos.dart';
import 'package:the_best_app/Database/Daos/UserInfosdaos.dart';

import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Database/Entities/UserInfos.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Database/Daos/fitbitDao.dart';

//The generated code will be in database.g.dart
part 'database.g.dart';

//Here we are saying that this is the first version of the Database and it has just 1 entity, i.e., Todo
@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [
  UsersCredentials,
  UserInfos,
  myFitbitData,
  SleepData,
  ActivityData,
  StepsData,
  HeartData
])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  UserCrededentialsDao get user_crededentials_dao;
  FitbitDao get fitbitDao;
  SleepDao get sleepDao;
  ActivityDao get activityDao;
  StepsDao get stepsDao;
  HeartDao get heartDao;
  UserInfosDao get user_infos_dao;
}//AppDatabase