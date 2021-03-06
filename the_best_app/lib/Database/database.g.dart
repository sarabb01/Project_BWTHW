// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

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

  UserInfosDao? _user_infos_daoInstance;

  VoucherDao? _voucher_daoInstance;

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
            'CREATE TABLE IF NOT EXISTS `UserInfos` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userid` INTEGER NOT NULL, `name` TEXT NOT NULL, `surname` TEXT NOT NULL, `gender` TEXT NOT NULL, `dateofbirth` INTEGER NOT NULL, `usertarget` TEXT NOT NULL, FOREIGN KEY (`userid`) REFERENCES `UsersCredentials` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `myFitbitData` (`keyDate` INTEGER NOT NULL, `sleepHours` INTEGER NOT NULL, `calories` INTEGER NOT NULL, `steps` INTEGER NOT NULL, `cardio` INTEGER NOT NULL, `detailDate` INTEGER NOT NULL, `username` TEXT NOT NULL, PRIMARY KEY (`keyDate`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VoucherList` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userid` INTEGER NOT NULL, `discount` TEXT NOT NULL, `shop_name` TEXT NOT NULL, `QRcode_path` TEXT NOT NULL, `discount_code` TEXT NOT NULL, `front_image_path` TEXT NOT NULL, FOREIGN KEY (`userid`) REFERENCES `UsersCredentials` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');

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
  UserInfosDao get user_infos_dao {
    return _user_infos_daoInstance ??= _$UserInfosDao(database, changeListener);
  }

  @override
  VoucherDao get voucher_dao {
    return _voucher_daoInstance ??= _$VoucherDao(database, changeListener);
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
        user, OnConflictStrategy.abort);
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
                  'keyDate': item.keyDate,
                  'sleepHours': item.sleepHours,
                  'calories': item.calories,
                  'steps': item.steps,
                  'cardio': item.cardio,
                  'detailDate': item.detailDate,
                  'username': item.username
                }),
        _myFitbitDataUpdateAdapter = UpdateAdapter(
            database,
            'myFitbitData',
            ['keyDate'],
            (myFitbitData item) => <String, Object?>{
                  'keyDate': item.keyDate,
                  'sleepHours': item.sleepHours,
                  'calories': item.calories,
                  'steps': item.steps,
                  'cardio': item.cardio,
                  'detailDate': item.detailDate,
                  'username': item.username
                }),
        _myFitbitDataDeletionAdapter = DeletionAdapter(
            database,
            'myFitbitData',
            ['keyDate'],
            (myFitbitData item) => <String, Object?>{
                  'keyDate': item.keyDate,
                  'sleepHours': item.sleepHours,
                  'calories': item.calories,
                  'steps': item.steps,
                  'cardio': item.cardio,
                  'detailDate': item.detailDate,
                  'username': item.username
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<myFitbitData> _myFitbitDataInsertionAdapter;

  final UpdateAdapter<myFitbitData> _myFitbitDataUpdateAdapter;

  final DeletionAdapter<myFitbitData> _myFitbitDataDeletionAdapter;

  @override
  Future<List<myFitbitData>> findAllFitbitData() async {
    return _queryAdapter.queryList('SELECT * FROM myFitbitData',
        mapper: (Map<String, Object?> row) => myFitbitData(
            row['keyDate'] as int,
            sleepHours: row['sleepHours'] as int,
            calories: row['calories'] as int,
            steps: row['steps'] as int,
            cardio: row['cardio'] as int,
            detailDate: row['detailDate'] as int,
            username: row['username'] as String));
  }

  @override
  Future<List<myFitbitData>> findAllFitbitDataUser(String username) async {
    return _queryAdapter.queryList(
        'SELECT * FROM myFitbitData WHERE username = ?1',
        mapper: (Map<String, Object?> row) => myFitbitData(
            row['keyDate'] as int,
            sleepHours: row['sleepHours'] as int,
            calories: row['calories'] as int,
            steps: row['steps'] as int,
            cardio: row['cardio'] as int,
            detailDate: row['detailDate'] as int,
            username: row['username'] as String),
        arguments: [username]);
  }

  @override
  Future<void> insertFitbitData(myFitbitData newdata) async {
    await _myFitbitDataInsertionAdapter.insert(
        newdata, OnConflictStrategy.replace);
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

class _$UserInfosDao extends UserInfosDao {
  _$UserInfosDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userInfosInsertionAdapter = InsertionAdapter(
            database,
            'UserInfos',
            (UserInfos item) => <String, Object?>{
                  'id': item.id,
                  'userid': item.userId,
                  'name': item.name,
                  'surname': item.surname,
                  'gender': item.gender,
                  'dateofbirth': _dateTimeConverter.encode(item.dateofbirth),
                  'usertarget': item.usertarget
                }),
        _userInfosUpdateAdapter = UpdateAdapter(
            database,
            'UserInfos',
            ['id'],
            (UserInfos item) => <String, Object?>{
                  'id': item.id,
                  'userid': item.userId,
                  'name': item.name,
                  'surname': item.surname,
                  'gender': item.gender,
                  'dateofbirth': _dateTimeConverter.encode(item.dateofbirth),
                  'usertarget': item.usertarget
                }),
        _userInfosDeletionAdapter = DeletionAdapter(
            database,
            'UserInfos',
            ['id'],
            (UserInfos item) => <String, Object?>{
                  'id': item.id,
                  'userid': item.userId,
                  'name': item.name,
                  'surname': item.surname,
                  'gender': item.gender,
                  'dateofbirth': _dateTimeConverter.encode(item.dateofbirth),
                  'usertarget': item.usertarget
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserInfos> _userInfosInsertionAdapter;

  final UpdateAdapter<UserInfos> _userInfosUpdateAdapter;

  final DeletionAdapter<UserInfos> _userInfosDeletionAdapter;

  @override
  Future<List<UserInfos>> findAllUsersInfos() async {
    return _queryAdapter.queryList('SELECT * FROM UserInfos',
        mapper: (Map<String, Object?> row) => UserInfos(
            row['id'] as int?,
            row['userid'] as int,
            row['name'] as String,
            row['surname'] as String,
            row['gender'] as String,
            _dateTimeConverter.decode(row['dateofbirth'] as int),
            row['usertarget'] as String));
  }

  @override
  Future<UserInfos?> checkUserInfos(int userid) async {
    return _queryAdapter.query('SELECT * FROM UserInfos WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => UserInfos(
            row['id'] as int?,
            row['userid'] as int,
            row['name'] as String,
            row['surname'] as String,
            row['gender'] as String,
            _dateTimeConverter.decode(row['dateofbirth'] as int),
            row['usertarget'] as String),
        arguments: [userid]);
  }

  @override
  Future<void> addUserInfos(UserInfos user) async {
    await _userInfosInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUserInfos(UserInfos user) async {
    await _userInfosUpdateAdapter.update(user, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteUserInfos(UserInfos user) async {
    await _userInfosDeletionAdapter.delete(user);
  }

  @override
  Future<void> deleteAllUsersInfos(List<UserInfos> users) async {
    await _userInfosDeletionAdapter.deleteList(users);
  }
}

class _$VoucherDao extends VoucherDao {
  _$VoucherDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _voucherListInsertionAdapter = InsertionAdapter(
            database,
            'VoucherList',
            (VoucherList item) => <String, Object?>{
                  'id': item.id,
                  'userid': item.userId,
                  'discount': item.discount,
                  'shop_name': item.shop_name,
                  'QRcode_path': item.QRcode_path,
                  'discount_code': item.discount_code,
                  'front_image_path': item.front_image_path
                }),
        _voucherListUpdateAdapter = UpdateAdapter(
            database,
            'VoucherList',
            ['id'],
            (VoucherList item) => <String, Object?>{
                  'id': item.id,
                  'userid': item.userId,
                  'discount': item.discount,
                  'shop_name': item.shop_name,
                  'QRcode_path': item.QRcode_path,
                  'discount_code': item.discount_code,
                  'front_image_path': item.front_image_path
                }),
        _voucherListDeletionAdapter = DeletionAdapter(
            database,
            'VoucherList',
            ['id'],
            (VoucherList item) => <String, Object?>{
                  'id': item.id,
                  'userid': item.userId,
                  'discount': item.discount,
                  'shop_name': item.shop_name,
                  'QRcode_path': item.QRcode_path,
                  'discount_code': item.discount_code,
                  'front_image_path': item.front_image_path
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VoucherList> _voucherListInsertionAdapter;

  final UpdateAdapter<VoucherList> _voucherListUpdateAdapter;

  final DeletionAdapter<VoucherList> _voucherListDeletionAdapter;

  @override
  Future<List<VoucherList>?> findAllUserVouchers(int userid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM VoucherList WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => VoucherList(
            row['id'] as int?,
            row['userid'] as int,
            row['discount'] as String,
            row['shop_name'] as String,
            row['QRcode_path'] as String,
            row['discount_code'] as String,
            row['front_image_path'] as String),
        arguments: [userid]);
  }

  @override
  Future<void> addUserVoucher(VoucherList voucher) async {
    await _voucherListInsertionAdapter.insert(
        voucher, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUserVoucher(VoucherList voucher) async {
    await _voucherListUpdateAdapter.update(voucher, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteUserVoucher(VoucherList voucher) async {
    await _voucherListDeletionAdapter.delete(voucher);
  }

  @override
  Future<void> deleteAllUsersVoucher(List<VoucherList> voucherlist) async {
    await _voucherListDeletionAdapter.deleteList(voucherlist);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
