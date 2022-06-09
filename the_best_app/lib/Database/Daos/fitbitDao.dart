import 'package:floor/floor.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';

@dao
abstract class FitbitDao {
  @Query('SELECT * FROM myFitbitData')
  Future<List<myFitbitData>> findAllFitbitData();

  @Insert(
      onConflict: OnConflictStrategy
          .ignore) // In ordert to avoid duplicates within the users
  Future<void> insertFitbitData(myFitbitData newdata);

  @delete
  Future<void> deleteAllFitbitData(List<myFitbitData> newdata);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateFitbitData(myFitbitData newdata);
}
