import 'package:floor/floor.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';

@dao
abstract class FitbitDao {
  @Query('SELECT * FROM FitbitData')
  Future<List<myFitbitData>> findAllFitbitData();

  @insert
  Future<void> insertFitbitData(myFitbitData newdata);

  @delete
  Future<void> deleteAllFitbitData(List<myFitbitData> newdata);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateFitbitData(myFitbitData newdata);
}
