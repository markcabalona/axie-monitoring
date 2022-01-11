// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driftdb.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final int? id;
  final String? name;
  final String username;
  final String password;
  User({this.id, this.name, required this.username, required this.password});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      username: Value(username),
      password: Value(password),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String?>(name),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
    };
  }

  User copyWith({int? id, String? name, String? username, String? password}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        password: password ?? this.password,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, username, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.username == this.username &&
          other.password == this.password);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int?> id;
  final Value<String?> name;
  final Value<String> username;
  final Value<String> password;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required String username,
    required String password,
  })  : username = Value(username),
        password = Value(password);
  static Insertable<User> custom({
    Expression<int?>? id,
    Expression<String?>? name,
    Expression<String>? username,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    });
  }

  UsersCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? name,
      Value<String>? username,
      Value<String>? password}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  final GeneratedDatabase _db;
  final String? _alias;
  $UsersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, username, password];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(_db, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final int? id;
  final int userId;
  final String name;
  final String roninId;
  final double percentage;
  Player(
      {this.id,
      required this.userId,
      required this.name,
      required this.roninId,
      required this.percentage});
  factory Player.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Player(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      roninId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}ronin_id'])!,
      percentage: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}percentage'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['user_id'] = Variable<int>(userId);
    map['name'] = Variable<String>(name);
    map['ronin_id'] = Variable<String>(roninId);
    map['percentage'] = Variable<double>(percentage);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userId: Value(userId),
      name: Value(name),
      roninId: Value(roninId),
      percentage: Value(percentage),
    );
  }

  factory Player.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      id: serializer.fromJson<int?>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      roninId: serializer.fromJson<String>(json['roninId']),
      percentage: serializer.fromJson<double>(json['percentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'userId': serializer.toJson<int>(userId),
      'name': serializer.toJson<String>(name),
      'roninId': serializer.toJson<String>(roninId),
      'percentage': serializer.toJson<double>(percentage),
    };
  }

  Player copyWith(
          {int? id,
          int? userId,
          String? name,
          String? roninId,
          double? percentage}) =>
      Player(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        roninId: roninId ?? this.roninId,
        percentage: percentage ?? this.percentage,
      );
  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('roninId: $roninId, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, roninId, percentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.roninId == this.roninId &&
          other.percentage == this.percentage);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<int?> id;
  final Value<int> userId;
  final Value<String> name;
  final Value<String> roninId;
  final Value<double> percentage;
  const PlayersCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.roninId = const Value.absent(),
    this.percentage = const Value.absent(),
  });
  PlayersCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String name,
    required String roninId,
    required double percentage,
  })  : userId = Value(userId),
        name = Value(name),
        roninId = Value(roninId),
        percentage = Value(percentage);
  static Insertable<Player> custom({
    Expression<int?>? id,
    Expression<int>? userId,
    Expression<String>? name,
    Expression<String>? roninId,
    Expression<double>? percentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (roninId != null) 'ronin_id': roninId,
      if (percentage != null) 'percentage': percentage,
    });
  }

  PlayersCompanion copyWith(
      {Value<int?>? id,
      Value<int>? userId,
      Value<String>? name,
      Value<String>? roninId,
      Value<double>? percentage}) {
    return PlayersCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      roninId: roninId ?? this.roninId,
      percentage: percentage ?? this.percentage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (roninId.present) {
      map['ronin_id'] = Variable<String>(roninId.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('roninId: $roninId, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }
}

class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PlayersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int?> userId = GeneratedColumn<int?>(
      'user_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES users(id)');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _roninIdMeta = const VerificationMeta('roninId');
  @override
  late final GeneratedColumn<String?> roninId = GeneratedColumn<String?>(
      'ronin_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _percentageMeta = const VerificationMeta('percentage');
  @override
  late final GeneratedColumn<double?> percentage = GeneratedColumn<double?>(
      'percentage', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userId, name, roninId, percentage];
  @override
  String get aliasedName => _alias ?? 'players';
  @override
  String get actualTableName => 'players';
  @override
  VerificationContext validateIntegrity(Insertable<Player> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('ronin_id')) {
      context.handle(_roninIdMeta,
          roninId.isAcceptableOrUnknown(data['ronin_id']!, _roninIdMeta));
    } else if (isInserting) {
      context.missing(_roninIdMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage']!, _percentageMeta));
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Player.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(_db, alias);
  }
}

abstract class _$AxieDatabase extends GeneratedDatabase {
  _$AxieDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final UserDao userDao = UserDao(this as AxieDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, players];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$PlayerDaoMixin on DatabaseAccessor<AxieDatabase> {
  $PlayersTable get players => attachedDatabase.players;
  $UsersTable get users => attachedDatabase.users;
}
mixin _$UserDaoMixin on DatabaseAccessor<AxieDatabase> {
  $UsersTable get users => attachedDatabase.users;
}
