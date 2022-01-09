import 'dart:developer';
import 'dart:io';

import 'package:axie_monitoring/api/fetchslpstats.dart';
import 'package:axie_monitoring/database/dbhelper.dart';
import 'package:axie_monitoring/models/player.dart';
import 'package:axie_monitoring/models/user.dart';
import 'package:flutter/material.dart';
import 'package:cron/cron.dart';

class PlayersProvider extends ChangeNotifier {
  PlayersProvider() {
    _databaseHelper = DatabaseHelper.instance;
    _fakeUser();
    _addFakePlayers();
    updateSlpStatsValues();
  }

  late DatabaseHelper _databaseHelper;

  final _cron = Cron();

  final List<Player> _players = [];

  List<Player> get players => _players;

  User? _user;

  @override
  void dispose() {
    _cron.close();
    _databaseHelper.close();
    super.dispose();
  }

  void _fakeUser() async {
    try {
      _user = await _databaseHelper.createUser(
        User(
          name: "FooBar1",
          username: "foobar_username2",
          password: "password",
        ),
      );
    } catch (e) {
      _user = await _databaseHelper.fetchUser(2);
      log(e.toString());
    }
  }

  double get totalSlp {
    return _players.isEmpty
        ? 0
        : _players
            .map((player) => (player.slp.total * (1 - player.percentage)))
            .toList()
            .reduce((value, element) => value + element);
  }

  void _addFakePlayers() {
    //testing values
    List<String> _fakeRonins = [
      "0x",
      "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
      "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
      "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
      "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
      "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
      "0x26d252724d08a30151ab5c87bd6b4fb5eadb1500",
    ];
    List<Player> _fakePlayers = List.generate(
        _fakeRonins.length,
        (i) => Player(
            roninId: _fakeRonins[i], name: "test ${i + 1}", percentage: .5));
    for (Player fakePlayer in _fakePlayers) {
      addPlayer(fakePlayer);
    }
  }

  void addPlayer(Player newPlayer) async {
    try {
      newPlayer.slp = await AxieApiHelper.fetchSlpStats(newPlayer.roninId);
    } catch (e) {
      log("${newPlayer.name} has no record");
      log(e.toString());
      return;
    }
    try {
      Player? _player = await _databaseHelper.fetchPlayer(
        _user!.id,
        newPlayer.roninId,
      );

      if (_player == null) {
        log("Player Added: " + newPlayer.name);
      } else {
        log("Player Already Existing: " + newPlayer.name);
      }
      _players.add(newPlayer);
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void updateSlpStatsValues() {
    //fetch data every fourhours
    _cron.schedule(Schedule.parse("0 */4 * * *"), () {
      for (Player player in _players) {
        player.update();
        log("updated ${player.name}");
      }
      notifyListeners();
    });
  }
}
