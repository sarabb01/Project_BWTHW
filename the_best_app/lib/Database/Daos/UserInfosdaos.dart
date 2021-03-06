// Flutter Packages
import 'package:floor/floor.dart';
// Screens
import 'package:the_best_app/Database/Entities/UserInfos.dart';

@dao
abstract class UserInfosDao {
  @Query('SELECT * FROM UserInfos')
  Future<List<UserInfos>> findAllUsersInfos();

  @Query('SELECT * FROM UserInfos WHERE userId = :userid')
  Future<UserInfos?> checkUserInfos(int userid);

  @insert
  Future<void> addUserInfos(UserInfos user);

  @Update(
      onConflict: OnConflictStrategy
          .replace) // In ordert to avoid duplicates within the users
  Future<void> updateUserInfos(UserInfos user);

  @delete
  Future<void> deleteUserInfos(UserInfos user);

  @delete
  Future<void> deleteAllUsersInfos(List<UserInfos> users);
}
