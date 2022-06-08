import 'package:floor/floor.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';

@dao
abstract class SleepDao {
  @Query('SELECT * FROM SleepData')
  Future<List<SleepData>> findAllSleepData();

  @insert
  Future<void> insertSleepData(SleepData newdata);

  @delete
  Future<void> deleteAllSleepData(List<SleepData> newdata);
}
