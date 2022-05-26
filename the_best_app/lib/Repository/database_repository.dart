import 'package:prova_project/Database/user_cred_database.dart';
import 'package:prova_project/Database/Entities/UserCreds.dart';
import 'package:flutter/material.dart';

class UsersDatabaseRepo extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  UsersDatabaseRepo({required this.database});

  // DATABASE METHODS IMPLEMENTATION:

  // ######### SHOWING ALL THE USERS #########
  //@Query('SELECT username FROM Users_Credentials')
  Future<List<String>?> findAllUsers() async {
    final results = await database.user_crededentials_dao.findAllUsers();
    return results;
  }

  // ######### CHECKING USER PRESENCE #########
  //@Query('SELECT username FROM Users_Credentialss WHERE username = :username')
  Future<UsersCredentials?> findUser(String username) async {
    final results = await database.user_crededentials_dao.checkUser(username);
    return results;
  }

  // ######### ADDING NEW USER #########
  //@Insert(onConflict: OnConflictStrategy.rollback) // In ordert to avoid duplicates within the users
  Future<void> addUser(UsersCredentials user) async {
    await database.user_crededentials_dao.addUser(user);
    notifyListeners();
  }

  // ######### UPDATING USER INFOS #########
  //@Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserPassword(UsersCredentials user) async {
    await database.user_crededentials_dao.updateUserPassword(user);
    notifyListeners();
  }

  // ######### DELETING USER #########
  //@delete
  Future<void> deleteUser(UsersCredentials user) async {
    await database.user_crededentials_dao.deleteUser(user);
    notifyListeners();
  }

  // ######### DELETING ALL USERS #########
  //@delete
  Future<void> deleteAllUsers(List<UsersCredentials> users) async {
    await database.user_crededentials_dao.deleteAllUsers;
    notifyListeners();
  }

  //
  //
  //
}
