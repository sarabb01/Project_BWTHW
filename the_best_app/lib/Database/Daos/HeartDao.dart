import 'package:floor/floor.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';

@dao
abstract class HeartDao {
  @Query('SELECT * FROM HeartData')
  Future<List<HeartData>> findAllHeartData();

  @insert
  Future<void> insertHeartData(HeartData newdata);
}
