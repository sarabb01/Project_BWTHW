import 'package:floor/floor.dart';
import 'package:prova_project/Database/Entities/User_Creds.dart';

@dao
abstract class User_Crededentials_Dao {
  @Query('SELECT username FROM Users_Credentials')
  Future<List<String>?> findAllUsers();

  @Query('SELECT * FROM Users_Credentials WHERE username = :username')
  Future<Users_Credentials?> checkUser(String username);

  @Insert(
      onConflict: OnConflictStrategy
          .rollback) // In ordert to avoid duplicates within the users
  Future<void> addUser(Users_Credentials user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserPassword(Users_Credentials user);

  @delete
  Future<void> deleteUser(Users_Credentials user);

  @delete
  Future<void> deleteAllUsers(List<Users_Credentials> users);
}
