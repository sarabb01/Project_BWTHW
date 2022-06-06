// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cred_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserCrededentialsDao? _user_crededentials_daoInstance;

  FitbitDao? _fitbitDaoInstance;

  SleepDao? _sleepDaoInstance;

  ActivityDao? _activityDaoInstance;

  StepsDao? _stepsDaoInstance;

  HeartDao? _heartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UsersCredentials` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT NOT NULL, `password` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `myFitbitData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `sleepHours` INTEGER NOT NULL, `calories` INTEGER NOT NULL, `steps` INTEGER NOT NULL, `cardio` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SleepData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `sleepHours` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ActivityData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `calories` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `StepsData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `steps` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HeartData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `cardio` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserCrededentialsDao get user_crededentials_dao {
    return _user_crededentials_daoInstance ??=
        _$UserCrededentialsDao(database, changeListener);
  }

  @override
  FitbitDao get fitbitDao {
    return _fitbitDaoInstance ??= _$FitbitDao(database, changeListener);
  }

  @override
  SleepDao get sleepDao {
    return _sleepDaoInstance ??= _$SleepDao(database, changeListener);
  }

  @override
  ActivityDao get activityDao {
    return _activityDaoInstance ??= _$ActivityDao(database, changeListener);
  }

  @override
  StepsDao get stepsDao {
    return _stepsDaoInstance ??= _$StepsDao(database, changeListener);
  }

  @override
  HeartDao get heartDao {
    return _heartDaoInstance ??= _$HeartDao(database, changeListener);
  }
}

class _$UserCrededentialsDao extends UserCrededentialsDao {
  _$UserCrededentialsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _usersCredentialsInsertionAdapter = InsertionAdapter(
            database,
            'UsersCredentials',
            (UsersCredentials item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password
                }),
        _usersCredentialsUpdateAdapter = UpdateAdapter(
            database,
            'UsersCredentials',
            ['id'],
            (UsersCredentials item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password
                }),
        _usersCredentialsDeletionAdapter = DeletionAdapter(
            database,
            'UsersCredentials',
            ['id'],
            (UsersCredentials item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UsersCredentials> _usersCredentialsInsertionAdapter;

  final UpdateAdapter<UsersCredentials> _usersCredentialsUpdateAdapter;

  final DeletionAdapter<UsersCredentials> _usersCredentialsDeletionAdapter;

  @override
  Future<List<UsersCredentials>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM UsersCredentials',
        mapper: (Map<String, Object?> row) => UsersCredentials(
            row['id'] as int?,
            row['username'] as String,
            row['password'] as String));
  }

  @override
  Future<UsersCredentials?> checkUser(String username) async {
    return _queryAdapter.query(
        'SELECT * FROM UsersCredentials WHERE username = ?1',
        mapper: (Map<String, Object?> row) => UsersCredentials(
            row['id'] as int?,
            row['username'] as String,
            row['password'] as String),
        arguments: [username]);
  }

  @override
  Future<void> addUser(UsersCredentials user) async {
    await _usersCredentialsInsertionAdapter.insert(
        user, OnConflictStrategy.rollback);
  }

  @override
  Future<void> updateUserPassword(UsersCredentials user) async {
    await _usersCredentialsUpdateAdapter.update(
        user, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteUser(UsersCredentials user) async {
    await _usersCredentialsDeletionAdapter.delete(user);
  }

  @override
  Future<void> deleteAllUsers(List<UsersCredentials> users) async {
    await _usersCredentialsDeletionAdapter.deleteList(users);
  }
}

class _$FitbitDao extends FitbitDao {
  _$FitbitDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _myFitbitDataInsertionAdapter = InsertionAdapter(
            database,
            'myFitbitData',
            (myFitbitData item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'sleepHours': item.sleepHours,
                  'calories': item.calories,
                  'steps': item.steps,
                  'cardio': item.cardio
                }),
        _myFitbitDataUpdateAdapter = UpdateAdapter(
            database,
            'myFitbitData',
            ['id'],
            (myFitbitData item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'sleepHours': item.sleepHours,
                  'calories': item.calories,
                  'steps': item.steps,
                  'cardio': item.cardio
                }),
        _myFitbitDataDeletionAdapter = DeletionAdapter(
            database,
            'myFitbitData',
            ['id'],
            (myFitbitData item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'sleepHours': item.sleepHours,
                  'calories': item.calories,
                  'steps': item.steps,
                  'cardio': item.cardio
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<myFitbitData> _myFitbitDataInsertionAdapter;

  final UpdateAdapter<myFitbitData> _myFitbitDataUpdateAdapter;

  final DeletionAdapter<myFitbitData> _myFitbitDataDeletionAdapter;

  @override
  Future<List<myFitbitData>> findAllFitbitData() async {
    return _queryAdapter.queryList('SELECT * FROM FitbitData',
        mapper: (Map<String, Object?> row) => myFitbitData(
            row['id'] as int?, _dateTimeConverter.decode(row['date'] as int),
            sleepHours: row['sleepHours'] as int,
            calories: row['calories'] as int,
            steps: row['steps'] as int,
            cardio: row['cardio'] as int));
  }

  @override
  Future<void> insertFitbitData(myFitbitData newdata) async {
    await _myFitbitDataInsertionAdapter.insert(
        newdata, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateFitbitData(myFitbitData newdata) async {
    await _myFitbitDataUpdateAdapter.update(
        newdata, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteAllFitbitData(List<myFitbitData> newdata) async {
    await _myFitbitDataDeletionAdapter.deleteList(newdata);
  }
}

class _$SleepDao extends SleepDao {
  _$SleepDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _sleepDataInsertionAdapter = InsertionAdapter(
            database,
            'SleepData',
            (SleepData item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'sleepHours': item.sleepHours
                }),
        _sleepDataDeletionAdapter = DeletionAdapter(
            database,
            'SleepData',
            ['id'],
            (SleepData item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'sleepHours': item.sleepHours
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SleepData> _sleepDataInsertionAdapter;

  final DeletionAdapter<SleepData> _sleepDataDeletionAdapter;

  @override
  Future<List<SleepData>> findAllSleepData() async {
    return _queryAdapter.queryList('SELECT * FROM SleepData',
        mapper: (Map<String, Object?> row) => SleepData(
            row['id'] as int?,
            _dateTimeConverter.decode(row['date'] as int),
            row['sleepHours'] as int));
  }

  @override
  Future<void> insertSleepData(SleepData newdata) async {
    await _sleepDataInsertionAdapter.insert(newdata, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAllSleepData(List<SleepData> newdata) async {
    await _sleepDataDeletionAdapter.deleteList(newdata);
  }
}

class _$ActivityDao extends ActivityDao {
  _$ActivityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _activityDataInsertionAdapter = InsertionAdapter(
            database,
            'ActivityData',
            (ActivityData item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'calories': item.calories
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActivityData> _activityDataInsertionAdapter;

  @override
  Future<List<ActivityData>> findAllActivityData() async {
    return _queryAdapter.queryList('SELECT * FROM ActivityData',
        mapper: (Map<String, Object?> row) => ActivityData(
            row['id'] as int?,
            _dateTimeConverter.decode(row['date'] as int),
            row['calories'] as int));
  }

  @override
  Future<void> insertActivityData(ActivityData newdata) async {
    await _activityDataInsertionAdapter.insert(
        newdata, OnConflictStrategy.abort);
  }
}

class _$StepsDao extends StepsDao {
  _$StepsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _stepsDataInsertionAdapter = InsertionAdapter(
            database,
            'StepsData',
            (StepsData item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'steps': item.steps
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StepsData> _stepsDataInsertionAdapter;

  @override
  Future<List<StepsData>> findAllStepsData() async {
    return _queryAdapter.queryList('SELECT * FROM StepsData',
        mapper: (Map<String, Object?> row) => StepsData(
            row['id'] as int?,
            _dateTimeConverter.decode(row['date'] as int),
            row['steps'] as int));
  }

  @override
  Future<void> insertStepsData(StepsData newdata) async {
    await _stepsDataInsertionAdapter.insert(newdata, OnConflictStrategy.abort);
  }
}

class _$HeartDao extends HeartDao {
  _$HeartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _heartDataInsertionAdapter = InsertionAdapter(
            database,
            'HeartData',
            (HeartData item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'cardio': item.cardio
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HeartData> _heartDataInsertionAdapter;

  @override
  Future<List<HeartData>> findAllHeartData() async {
    return _queryAdapter.queryList('SELECT * FROM HeartData',
        mapper: (Map<String, Object?> row) => HeartData(
            row['id'] as int?,
            _dateTimeConverter.decode(row['date'] as int),
            row['cardio'] as int));
  }

  @override
  Future<void> insertHeartData(HeartData newdata) async {
    await _heartDataInsertionAdapter.insert(newdata, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
