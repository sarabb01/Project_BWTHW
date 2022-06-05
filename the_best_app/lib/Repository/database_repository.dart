import 'package:the_best_app/Database/database.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Database/Entities/UserInfos.dart';
import 'package:flutter/material.dart';

class UsersDatabaseRepo extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  UsersDatabaseRepo({required this.database});

  // DATABASE METHODS IMPLEMENTATION:

  // ################################
  // ######### SHOWING ALL THE USERS (From UsersCredentials Table) #########
  //@Query('SELECT username FROM Users_Credentials')
  Future<List<UsersCredentials>> findAllUsers() async {
    final results = await database.user_crededentials_dao.findAllUsers();
    return results;
  }

  // ######### SHOWING ALL USERS INFORMATIONS (From UserInfos Table) #########
  //@Query('SELECT username FROM Users_Credentials')
  Future<List<UserInfos>> findAllUsersInfos() async {
    final results = await database.user_infos_dao.findAllUsersInfos();
    return results;
  }
  // ################################

  // ################################
  // ######### CHECKING USER PRESENCE (From UsersCredentials Table) #########
  //@Query('SELECT * FROM Users_Credentialss WHERE username = :username')
  Future<UsersCredentials?> findUser(String username) async {
    final results = await database.user_crededentials_dao.checkUser(username);
    return results;
  }

  // ######### CHECKING USER INFORMATIONS (From UserInfos Table) #########
  //@Query('SELECT * FROM UserInfos WHERE username = :username')
  Future<UserInfos?> checkUserInfos(String username) async {
    final results = await database.user_infos_dao.checkUserInfos(username);
    return results;
  }
  // ################################

  // ################################
  // ######### ADDING NEW USER (From UsersCredentials Table) #########
  //@Insert(onConflict: OnConflictStrategy.rollback) // In ordert to avoid duplicates within the users
  Future<void> addUser(UsersCredentials user) async {
    await database.user_crededentials_dao.addUser(user);
    notifyListeners();
  }

  // ######### ADDING NEW USER INFOS (From UserInfos Table) #########
  //@Insert(onConflict: OnConflictStrategy.rollback) // In ordert to avoid duplicates within the users
  Future<void> addUserInfos(UserInfos user) async {
    await database.user_infos_dao.addUserInfos(user);
    notifyListeners();
  }
  // ################################

  // ################################
  // ######### UPDATING USER PASSWORD (From UsersCredentials Table) #########
  //@Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserPassword(UsersCredentials user) async {
    await database.user_crededentials_dao.updateUserPassword(user);
    notifyListeners();
  }

  // ######### UPDATING USER INFOS (From UserInfos Table) #########
  //@Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserInfos(UserInfos user) async {
    await database.user_infos_dao.updateUserInfos(user);
    notifyListeners();
  }
  // ################################

  // ################################
  // ######### DELETING USER (From UsersCredentials Table) #########
  //@delete
  Future<void> deleteUser(UsersCredentials user) async {
    await database.user_crededentials_dao.deleteUser(user);
    notifyListeners();
  }

  // ######### DELETING USER INFOS (From UserInfos Table) #########
  //@delete
  Future<void> deleteUserInfos(UserInfos user) async {
    await database.user_infos_dao.deleteUserInfos(user);
    notifyListeners();
  }
  // ################################

  // ################################
  // ######### DELETING ALL USERS (From UsersCredentials Table) #########
  //@delete
  Future<void> deleteAllUsers(List<UsersCredentials> users) async {
    await database.user_crededentials_dao.deleteAllUsers;
    notifyListeners();
  }

  // ######### DELETING ALL USERS (From UsersCredentials Table) #########
  //@delete
  Future<void> deleteAllUsersInfos(List<UserInfos> users) async {
    await database.user_infos_dao.deleteAllUsersInfos;
    notifyListeners();
  }
  // ################################
}
