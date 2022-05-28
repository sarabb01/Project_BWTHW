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
