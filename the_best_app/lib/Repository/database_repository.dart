import 'package:the_best_app/Database/user_cred_database.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:flutter/material.dart';

class UsersDatabaseRepo extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  UsersDatabaseRepo({required this.database});

  // DATABASE METHODS IMPLEMENTATION:

  // ######### SHOWING ALL THE USERS #########
  //@Query('SELECT username FROM Users_Credentials')
  Future<List<UsersCredentials>> findAllUsers() async {
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
  // METHODS TO MANAGE FITBIT DATA
  //myFitbitDATA
  //This method wraps the findAll..() method of the DAO
  Future<List<myFitbitData>> findAllFitbitData() async {
    final results = await database.fitbitDao.findAllFitbitData();
    return results;
  } //findAll

  //This method wraps the insert..() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertFitbitData(myFitbitData newdata) async {
    await database.fitbitDao.insertFitbitData(newdata);
    notifyListeners();
  } //insertActivity

  Future<void> deleteAllFitbitData(List<myFitbitData> newdata) async {
    await database.fitbitDao.deleteAllFitbitData(newdata);
    notifyListeners();
  } //insertActivity

  Future<void> updateFitbitData(myFitbitData data) async {
    await database.fitbitDao.updateFitbitData(data);
    notifyListeners();
  }

  //SLEEPDATA
  //This method wraps the findAll..() method of the DAO
  Future<List<SleepData>> findAllSleepData() async {
    final results = await database.sleepDao.findAllSleepData();
    return results;
  } //findAll

  //This method wraps the insert..() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertSleepData(SleepData newdata) async {
    await database.sleepDao.insertSleepData(newdata);
    notifyListeners();
  } //insertActivity

  Future<void> deleteAllSleepData(List<SleepData> newdata) async {
    await database.sleepDao.deleteAllSleepData(newdata);
    notifyListeners();
  } //insertActivity

// ACTIVITY (CALORIES)
  //This method wraps the findAll..() method of the DAO
  Future<List<ActivityData>> findAllActivityData() async {
    final results = await database.activityDao.findAllActivityData();
    return results;
  } //findAllActivityData

  //This method wraps the insert..() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertActivityData(ActivityData newdata) async {
    await database.activityDao.insertActivityData(newdata);
    notifyListeners();
  } //insertActivity

// STEPS
  //This method wraps the findAll..() method of the DAO
  Future<List<StepsData>> findAllStepsData() async {
    final results = await database.stepsDao.findAllStepsData();
    return results;
  } //findAllStepsData

  //This method wraps the insert..() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertStepsData(StepsData newdata) async {
    await database.stepsDao.insertStepsData(newdata);
    notifyListeners();
  } //insertActivity

// HEART
  //This method wraps the findAll..() method of the DAO
  Future<List<HeartData>> findAllHeartData() async {
    final results = await database.heartDao.findAllHeartData();
    return results;
  } //findAllActivityData

  //This method wraps the insert..() method of the DAO.
  //Then, it notifies the listeners that something changed.
  Future<void> insertHeartData(HeartData newdata) async {
    await database.heartDao.insertHeartData(newdata);
    notifyListeners();
  } //insertActivity

}
