//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:the_best_app/Database/typeConverters/dateTimeConverter.dart';
//Here, we are importing the daos of the database
import 'package:the_best_app/Database/Daos/fitbitDao.dart';
import 'package:the_best_app/Database/Daos/UserCreddaos.dart';
import 'package:the_best_app/Database/Daos/UserInfosdaos.dart';
import 'package:the_best_app/Database/Daos/VoucherDao.dart';
//Here, we are importing the entities
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Database/Entities/UserInfos.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Database/Entities/VouchersList.dart';

part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [
  UsersCredentials,
  UserInfos,
  myFitbitData,
  VoucherList,
])
abstract class AppDatabase extends FloorDatabase {
  UserCrededentialsDao get user_crededentials_dao;
  FitbitDao get fitbitDao;
  UserInfosDao get user_infos_dao;
  VoucherDao get voucher_dao;
} //AppDatabase
