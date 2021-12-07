import 'package:async/async.dart';
import 'package:path/path.dart' as paths;
import 'package:sqflite/sqflite.dart' as sqllite;
import 'sql.dart' as sql;

class DbManager {
  // Private constructor
  DbManager._private();

  // Singleton instance
  static DbManager _instance = DbManager._private();

  /// Factory constructor returns instance singleton
  factory DbManager() {
    return _instance;
  }

  // Memoizer that only executes once. Subsequent or concurrent requests
  // will only return the single computed result
  final _init = AsyncMemoizer<sqllite.Database>();

  Future<void> initialise() async {
    await this.database;
  }

  Future<sqllite.Database> get database async {
    return _init.runOnce(() async {
      return this._initialise();
    });
  }

  Future<sqllite.Database> _initialise() async {
    final base = await sqllite.getDatabasesPath();
    final path = paths.join(base, 'tracer.db');

    return sqllite.openDatabase(path, 
      onCreate: (db, version) async {
        for (var stmt in sql.SQL) {
          await db.execute(stmt);
        }
      },
      version: 1);
  }
}

class NotFoundException implements Exception {
  NotFoundException(): super();
}