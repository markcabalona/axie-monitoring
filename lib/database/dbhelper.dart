import 'dart:developer';

import 'package:axie_monitoring/database/player.dart';
import 'package:axie_monitoring/database/user.dart';
import 'package:axie_monitoring/models/player.dart';
import 'package:axie_monitoring/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper? _instance;

  static DatabaseHelper get instance {
    _instance ??= DatabaseHelper._();
    return _instance!;
  }

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      await initDb();
    }
    return _db;
  }

  Future<void> deleteDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "axie_monitoring_database.db");
    deleteDatabase(path);
  }

  Future<void> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "axie_monitoring_database.db");

    log("Opening Database");
    _db = await openDatabase(
      path,
      onConfigure: _onConfigure,
      onCreate: (db, version) async {
        try {
          await db.execute(
            '''CREATE TABLE if not exists ${UserTableFields.tablename} (${UserTableFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${UserTableFields.name} TEXT,
            ${UserTableFields.username} TEXT NOT NULL UNIQUE,
            ${UserTableFields.password} TEXT NOT NULL)''',
          );
          log("${UserTableFields.tablename} created");
        } catch (e) {
          log("error in users ${e.toString()}");
        }

        try {
          await db.execute(
            '''CREATE TABLE if not exists ${PlayerTableFields.tablename} (${PlayerTableFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${PlayerTableFields.name} TEXT,
            ${PlayerTableFields.userId} INTEGER,
            ${PlayerTableFields.roninId} TEXT NOT NULL UNIQUE,
            ${PlayerTableFields.percentage} REAL NOT NULL,
            CONSTRAINT ${PlayerTableFields.userId},
              FOREIGN KEY (${PlayerTableFields.userId})
              REFERENCES ${UserTableFields.tablename}(${UserTableFields.id}) ON DELETE NO ACTION ON UPDATE NO ACTION)''',
          );
          log("${PlayerTableFields.tablename} created");
        } catch (e) {
          log("error in players ${e.toString()}");
        }
//
        return;
      },
      version: 1,
    );

    log("Database opened");
  }

  _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<User> fetchUser(int id) async {
    List<Map<String, dynamic>> result = await _db!.query(
      UserTableFields.tablename,
      columns: UserTableFields.fields,
      where: "id = ?",
      whereArgs: [id],
    );

    return User.fromMap(result.first);
  }

  Future<User> createUser(User user) async {
    var count = Sqflite.firstIntValue(await _db!.rawQuery(
        "SELECT COUNT(*) FROM ${UserTableFields.tablename} WHERE ${UserTableFields.username} = ?",
        [user.username]));

    if (count == 0) {
      user.id = await _db!.insert(UserTableFields.tablename, user.toMap());
    } else {
      throw "Username is not available";
    }

    return user;
  }

  Future<Player> createPlayer(Player player) async {
    var count = Sqflite.firstIntValue(await _db!.rawQuery(
        "SELECT COUNT(*) FROM ${PlayerTableFields.tablename} WHERE ${PlayerTableFields.roninId} = ?",
        [player.roninId]));
    if (count == 0) {
      player.id =
          await _db!.insert(PlayerTableFields.tablename, player.toMap());
    } else {
      throw "Username is not available";
    }
    return player;
  }

  Future<Player?> fetchPlayer(int userId, String roninId) async {
    List<Map<String, dynamic>> result = await _db!.query(
      PlayerTableFields.tablename,
      columns: PlayerTableFields.fields,
      where:
          "${PlayerTableFields.userId} = ? AND ${PlayerTableFields.roninId} = ?",
      whereArgs: [userId, roninId],
    );

    if (result.isEmpty) {
      return null;
    }

    return Player.fromMap(result.first);
  }

  void close() {
    _db!.close();
  }
}
