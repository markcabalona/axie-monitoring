import 'dart:developer';
import 'package:axie_monitoring/api/fetchslpstats.dart';
import 'package:axie_monitoring/database/driftdbhelper.dart';
import 'package:axie_monitoring/models/player.dart';
import 'package:axie_monitoring/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cron/cron.dart';

import 'package:axie_monitoring/database/driftdb.dart' as drift_db_models;

class PlayersProvider extends ChangeNotifier {
  PlayersProvider() {
    _fakeUser();
    updateSlpStatsValues();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  final DriftDbHelper _dbHelper = DriftDbHelper.instance;

  final _cron = Cron();

  List<Player> get players => _user == null ? [] : _user!.players;

  User? _user;

  @override
  void dispose() {
    _cron.close();
    super.dispose();
  }

  void _fakeUser() async {
    _user = User(
      username: "foobar_username",
      password: "password",
      name: "FooBar1",
    );
    try {
      _user!.id = await _dbHelper.userDao.insertUser(
        drift_db_models.User(
          username: _user!.username,
          password: _user!.password,
          name: _user!.name,
        ),
      );
      log("Fake user successfully added ID: " + _user!.id.toString());
    } catch (e) {
      _user = await _dbHelper.userDao.getUser(1);
      log("Fake user Logged in: " + _user!.id.toString());
    }
    _user!.players = await _dbHelper.playerDao.getAllScholars(_user!.id);
    log(_user!.players.toString());
    for (Player player in _user!.players) {
      try {
        await addPlayer(player);
      } catch (e) {
        log(e.toString());
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  double get totalSlp {
    return _user!.players.isEmpty
        ? 0
        : _user!.players
            .map((player) => (player.slp.total * (1 - player.percentage)))
            .toList()
            .reduce((value, element) => value + element);
  }

  // void _addFakePlayers() {
  //   //testing values
  //   List<String> _fakeRonins = [
  //     "0x",
  //     "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
  //     "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
  //     "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
  //     "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
  //     "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
  //     "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
  //   ];
  //   List<Player> _fakePlayers = List.generate(
  //       _fakeRonins.length,
  //       (i) => Player(
  //           roninId: _fakeRonins[i], name: "test ${i + 1}", percentage: .5));
  //   for (Player fakePlayer in _fakePlayers) {
  //     addPlayer(fakePlayer);
  //   }
  // }

  Future<void> addPlayer(Player newPlayer) async {
    if (_user!.players.map((player) => player.roninId).toList().contains(newPlayer.roninId)) {
      newPlayer.slp = await AxieApiHelper.fetchSlpStats(newPlayer.roninId);
      throw ("Player is already in the list.");
    }
    try {
      newPlayer.userId = _user!.id;
      _dbHelper.playerDao.insertPlayer(drift_db_models.Player(
        name: newPlayer.name,
        roninId: newPlayer.roninId,
        percentage: newPlayer.percentage,
        userId: newPlayer.userId!,
      ));
      log("New Player Inserted: " + newPlayer.name);
    } catch (e) {
      log(newPlayer.name + ": " + e.toString());
      return;
    }
    try {
      newPlayer.slp = await AxieApiHelper.fetchSlpStats(newPlayer.roninId);
      _user!.players.add(newPlayer);
      log("Player Added: " + newPlayer.name);
    } catch (e) {
      log(e.toString());
      return;
    }
    notifyListeners();
  }

  void updateSlpStatsValues() {
    //fetch data every fourhours
    _cron.schedule(Schedule.parse("0 */4 * * *"), () {
      for (Player player in _user!.players) {
        player.update();
        log("updated ${player.name}");
      }
      notifyListeners();
    });
  }
}
