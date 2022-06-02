import 'package:floor/floor.dart';
import 'package:the_best_app/Database/Entities/UserInfos.dart';

@dao
abstract class UserCrededentialsDao {
  @Query('SELECT * FROM UserInfos')
  Future<List<UserInfos>> findAllUsersInfos();

  @Query('SELECT * FROM UserInfos WHERE username = :username')
  Future<UserInfos?> checkUserInfos(String username);

  @Insert(
      onConflict: OnConflictStrategy
          .rollback) // In ordert to avoid duplicates within the users
  Future<void> addUserInfos(UserInfos user);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateUserInfos(UserInfos user);

  @delete
  Future<void> deleteUserInfos(UserInfos user);

  @delete
  Future<void> deleteAllUsersInfos(List<UserInfos> users);
}
