//Imports that are necessary to the code generator of floor
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//Here, we are importing the entities and the daos of the database
import 'Daos/User_Cred_daos.dart';
import 'Entities/User_Creds.dart';

//The generated code will be in database.g.dart
part 'user_cred_database.g.dart';

//Here we are saying that this is the first version of the Database and it has just 1 entity, i.e., Todo
@Database(version: 1, entities: [Users_Credentials])
abstract class AppDatabase extends FloorDatabase {
  //Add all the daos as getters here
  User_Crededentials_Dao get user_crededentials_dao;
}//AppDatabase