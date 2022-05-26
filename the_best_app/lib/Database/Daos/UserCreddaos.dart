import 'package:floor/floor.dart';
import 'package:prova_project/Database/Entities/UserCreds.dart';

@dao
abstract class UserCrededentialsDao {
  @Query('SELECT username FROM UsersCredentials')
  Future<List<String>?> findAllUsers();

  @Query('SELECT * FROM UsersCredentials WHERE username = :username')
  Future<UsersCredentials?> checkUser(String username);

  @Insert(
      onConflict: OnConflictStrategy
          .rollback) // In ordert to avoid duplicates within the users
  Future<void> addUser(UsersCredentials user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserPassword(UsersCredentials user);

  @delete
  Future<void> deleteUser(UsersCredentials user);

  @delete
  Future<void> deleteAllUsers(List<UsersCredentials> users);
}
