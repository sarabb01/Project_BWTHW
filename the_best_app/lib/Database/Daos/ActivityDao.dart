import 'package:floor/floor.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';

@dao
abstract class ActivityDao {
  @Query('SELECT * FROM ActivityData')
  Future<List<ActivityData>> findAllActivityData();

  @insert
  Future<void> insertActivityData(ActivityData newdata);
}
