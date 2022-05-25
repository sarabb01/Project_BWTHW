import 'dart:ffi';

import 'package:floor/floor.dart';
import 'package:prova_project/Database/Entities/User_Creds.dart';

@dao
abstract class User_Crededentials_Dao {
  @Query('SELECT username FROM User_Credentials')
  Future<List<String>> findAllUsers();

  @Query(
      'SELECT username FROM User_Credentials WHERE id =: id AND username =: username')
  Stream<String> findUser(int id, String username);

  @Insert(
      onConflict: OnConflictStrategy
          .rollback) // In ordert to avoid duplicates within the users
  Future<List<String>> addUser(Users_Credentials user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserPassword(String password);

  @delete
  Future<void> deleteUser(Users_Credentials user);

  @delete
  Future<void> deleteAllUsers(List<Users_Credentials> users);
}
