// Database
import 'package:the_best_app/Database/Entities/VouchersList.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Database/Entities/UserInfos.dart';
import 'package:the_best_app/Database/database.dart';
// Flutter Packages
import 'package:flutter/material.dart';

class UsersDatabaseRepo extends ChangeNotifier {
  //The state of the database is just the AppDatabase
  final AppDatabase database;

  //Default constructor
  UsersDatabaseRepo({required this.database});

  // DATABASE METHODS IMPLEMENTATION:

  // ################################ USER CREDENTIALS ################################

  // ######### SHOWING ALL THE USERS (From UsersCredentials Table) #########
  //@Query('SELECT username FROM Users_Credentials')
  Future<List<UsersCredentials>> findAllUsers() async {
    final results = await database.user_crededentials_dao.findAllUsers();
    return results;
  }

  // ######### CHECKING USER PRESENCE (From UsersCredentials Table) #########
  //@Query('SELECT * FROM Users_Credentialss WHERE username = :username')
  Future<UsersCredentials?> findUser(String username) async {
    final results = await database.user_crededentials_dao.checkUser(username);
    return results;
  }

  // ######### ADDING NEW USER (From UsersCredentials Table) #########
  //@Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> addUser(UsersCredentials user) async {
    await database.user_crededentials_dao.addUser(user);
    notifyListeners();
  }

  // ######### UPDATING USER PASSWORD (From UsersCredentials Table) #########
  //@Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserPassword(UsersCredentials user) async {
    await database.user_crededentials_dao.updateUserPassword(user);
    notifyListeners();
  }

  // ######### DELETING USER (From UsersCredentials Table) #########
  //@delete
  Future<void> deleteUser(UsersCredentials user) async {
    await database.user_crededentials_dao.deleteUser(user);
    notifyListeners();
  }

  // ######### DELETING ALL USERS (From UsersCredentials Table) #########
  //@delete
  Future<void> deleteAllUsers(List<UsersCredentials> users) async {
    await database.user_crededentials_dao.deleteAllUsers;
    notifyListeners();
  }

  // ################################ USER INFORMATIONS ################################

  // ######### SHOWING ALL USERS INFORMATIONS (From UserInfos Table) #########
  //@Query('SELECT username FROM Users_Credentials')
  Future<List<UserInfos>> findAllUsersInfos() async {
    final results = await database.user_infos_dao.findAllUsersInfos();
    return results;
  }

  // ######### CHECKING USER INFORMATIONS (From UserInfos Table) #########
  //@Query('SELECT * FROM UserInfos WHERE username = :username')
  Future<UserInfos?> checkUserInfos(int userid) async {
    final results = await database.user_infos_dao.checkUserInfos(userid);
    return results;
  }

  // ######### ADDING NEW USER INFOS (From UserInfos Table) #########
  //@Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> addUserInfos(UserInfos user) async {
    await database.user_infos_dao.addUserInfos(user);
    notifyListeners();
  }

  // ######### UPDATING USER INFOS (From UserInfos Table) #########
  //@Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserInfos(UserInfos user) async {
    await database.user_infos_dao.updateUserInfos(user);
    notifyListeners();
  }

  // ######### DELETING USER INFOS (From UserInfos Table) #########
  //@delete
  Future<void> deleteUserInfos(UserInfos user) async {
    await database.user_infos_dao.deleteUserInfos(user);
    notifyListeners();
  }

  // ######### DELETING ALL USERS (From UserInfos Table) #########
  //@delete
  Future<void> deleteAllUsersInfos(List<UserInfos> users) async {
    await database.user_infos_dao.deleteAllUsersInfos;
    notifyListeners();
  }

  // ################################ USER VOUCHERS ################################

  // ######### SHOWING ALL USER VOUCHERS (From VoucherList Table) #########
  //@Query('SELECT * FROM VoucherList WHERE userId = :userid')
  Future<List<VoucherList>?> findAllUserVouchers(int id) async {
    final results = await database.voucher_dao.findAllUserVouchers(id);
    return results;
  }

  // ######### ADDING NEW USER VOUCHER (From VoucherList Table)) #########
  //@Insert(onConflict: OnConflictStrategy.rollback)
  Future<void> addUserVoucher(VoucherList voucher) async {
    await database.voucher_dao.addUserVoucher(voucher);
    notifyListeners();
  }

  // ######### UPDATING USER VOUCHERS (From VoucherList Table) #########
  //@Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserVoucher(VoucherList voucher) async {
    await database.voucher_dao.updateUserVoucher(voucher);
    notifyListeners();
  }

  // ######### DELETING USER VOUCHER (From VoucherList Table) #########
  //@delete
  Future<void> deleteUserVoucher(VoucherList voucher) async {
    await database.voucher_dao.deleteUserVoucher(voucher);
    notifyListeners();
  }

  // ######### DELETING ALL USER VOUCHERS (From VoucherList Table) #########
  //@delete
  Future<void> deleteAllUsersVoucher(List<VoucherList> all) async {
    await database.voucher_dao.deleteAllUsersVoucher(all);
    notifyListeners();
  }

  // ################################ USERS FITBIT DATA ################################

  // ######### SHOWING ALL USERS FITBIT DATA (From myFitbitDATA Table) #########
  // @Query('SELECT * FROM myFitbitData')
  Future<List<myFitbitData>> findAllFitbitData() async {
    final results = await database.fitbitDao.findAllFitbitData();
    return results;
  }

  // ######### SHOWING ALL USER FITBIT DATA (From myFitbitDATA Table) #########
  // @Query('SELECT * FROM myFitbitData WHERE username = :username')
  Future<List<myFitbitData>> findAllFitbitDataUser(String username) async {
    final results = await database.fitbitDao.findAllFitbitDataUser(username);
    return results;
  }

  // ######### ADDING USER-SPECIFIC FITBIT DATA (From myFitbitDATA Table) #########
  // @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFitbitData(myFitbitData newdata) async {
    await database.fitbitDao.insertFitbitData(newdata);
    notifyListeners();
  }

  // ######### REMOVING USER-SPECIFIC FITBIT DATA (From myFitbitDATA Table) #########
  // OSS: WE can delete either totally/partially user-specific fit bit data or
  // all fit bit data dependingon the list of myFitvitData records reported
  // @delete
  Future<void> deleteAllFitbitData(List<myFitbitData> newdata) async {
    await database.fitbitDao.deleteAllFitbitData(newdata);
    notifyListeners();
  }

  // ######### UPDATING USER-SPECIFIC FITBIT DATA (From myFitbitDATA Table) #########
  // @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateFitbitData(myFitbitData data) async {
    await database.fitbitDao.updateFitbitData(data);
    notifyListeners();
  }
}
