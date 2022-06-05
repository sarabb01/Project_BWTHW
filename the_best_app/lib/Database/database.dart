//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'typeConverters/dateTimeConverter.dart';

//Here, we are importing the entities and the daos of the database
import 'Daos/UserCreddaos.dart';
import 'Daos/UserInfosdaos.dart';
import 'Entities/UserCreds.dart';
import 'Entities/UserInfos.dart';

//The generated code will be in database.g.dart
part 'database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [UsersCredentials, UserInfos])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  UserCrededentialsDao get user_crededentials_dao;
  UserInfosDao get user_infos_dao;
}//AppDatabase