import 'package:axie_monitoring/constants.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';
import 'package:axie_monitoring/models/user.dart' as user_model;
import 'package:axie_monitoring/models/player.dart' as player_model;

part 'driftdb.g.dart';

//database connection
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

//database helper
@DriftDatabase(tables: [Users, Players], daos: [UserDao])
class AxieDatabase extends _$AxieDatabase {
  AxieDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from == 1) {
            await migrator.addColumn(users, users.id);
            await migrator.createTable(users);
          }
          if (from == 2) {
            await migrator.addColumn(players, players.name);
            await migrator.createTable(players);
          }
        },
      );
}

//database tables

class Users extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get username => text()
      .customConstraint("UNIQUE")
      .withLength(min: LoginConst.usernameMin, max: LoginConst.usernameMax)();
  TextColumn get password => text()
      .withLength(min: LoginConst.passwordMin, max: LoginConst.passwordMax)();
}

class Players extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get userId => integer().customConstraint('REFERENCES users(id)')();
  TextColumn get name => text()();
  TextColumn get roninId => text()();
  RealColumn get percentage => real()();
}

class Scholar {
  final User user;
  final player_model.Player player;

  Scholar({
    required this.user,
    required this.player,
  });
}

@DriftAccessor(tables: [Players, Users])
class PlayerDao extends DatabaseAccessor<AxieDatabase> with _$PlayerDaoMixin {
  final AxieDatabase db;
  PlayerDao(this.db) : super(db);

  Future<List<player_model.Player>> getAllScholars(int userId) {
    return (select(players)..where((player) => player.userId.equals(userId))).join(
        [leftOuterJoin(users, users.id.equalsExp(players.userId))]).map((row) {
      var _playerDb = row.readTable(players);
      return player_model.Player(
        name: _playerDb.name,
        roninId: _playerDb.roninId,
        percentage: _playerDb.percentage,
      );
    }).get();
  }

  Future<int> insertPlayer(Insertable<Player> player) =>
      into(players).insert(player);
}

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AxieDatabase> with _$UserDaoMixin {
  final AxieDatabase db;

  UserDao(this.db) : super(db);

  Future insertUser(Insertable<User> user) => into(users).insert(user);
  Future<user_model.User> getUser(int id) {
    var user =
        (select(users)..where((user) => user.id.equals(id))).map((result) {
      var _user = user_model.User(
        name: result.name ?? "No Name",
        username: result.username,
        password: result.password,
      );
      _user.id = result.id!;
      return _user;
    }).get();
    return (user.then((value) => value.first));
  }
}
