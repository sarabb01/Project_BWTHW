import 'package:floor/floor.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';

@dao
abstract class UserCrededentialsDao {
  @Query('SELECT * FROM UsersCredentials')
  Future<List<UsersCredentials>> findAllUsers();

  @Query('SELECT * FROM UsersCredentials WHERE username = :username')
  Future<UsersCredentials?> checkUser(String username);

  @insert
  Future<void> addUser(UsersCredentials user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserPassword(UsersCredentials user);

  @delete
  Future<void> deleteUser(UsersCredentials user);

  @delete
  Future<void> deleteAllUsers(List<UsersCredentials> users);
}
