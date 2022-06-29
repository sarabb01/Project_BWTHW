import 'package:floor/floor.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';

@dao
abstract class FitbitDao {
  @Query('SELECT * FROM myFitbitData')
  Future<List<myFitbitData>> findAllFitbitData();

  @Query('SELECT * FROM myFitbitData WHERE username = :username')
  Future<List<myFitbitData>> findAllFitbitDataUser(String username);

  @Insert(
      onConflict: OnConflictStrategy
          .replace) // In ordert to avoid duplicates within the users
  Future<void> insertFitbitData(myFitbitData newdata);

  @delete
  Future<void> deleteAllFitbitData(List<myFitbitData> newdata);

  @Update(
      onConflict: OnConflictStrategy
          .replace) // In ordert to avoid duplicates within the users
  Future<void> updateFitbitData(myFitbitData newdata);
}
