import 'package:floor/floor.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';

@dao
abstract class StepsDao {
  @Query('SELECT * FROM StepsData')
  Future<List<StepsData>> findAllStepsData();

  @insert
  Future<void> insertStepsData(StepsData newdata);
}
