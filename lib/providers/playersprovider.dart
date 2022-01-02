import 'dart:developer';

import 'package:axie_monitoring/api/fetchslpstats.dart';
import 'package:axie_monitoring/models/player.dart';
import 'package:flutter/material.dart';
import 'package:cron/cron.dart';

class PlayersProvider extends ChangeNotifier {
  final _cron = Cron();
  final List<Player> _players = [];

  PlayersProvider() {
    updateValues();
    _addFakePlayers();
  }

  List<Player> get players => _players;

  int get totalSlp {
    return _players.isEmpty
        ? 0
        : _players
            .map((player) =>
                (player.slp.total * (1 - player.percentage)).toInt())
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
    newPlayer.slp = await ApiHelper.fetchSlpStats(newPlayer.roninId);
    _players.add(newPlayer);
    log("added");
    notifyListeners();
  }

  void updateValues() {
    //every fetch data fourhours
    _cron.schedule(Schedule.parse("*/1 * * * *"), () {
      for (Player player in _players) {
        player.update();
        log("updated ${player.name}");
      }
      notifyListeners();
    });
  }

  void closeCron() {
    _cron.close();
  }
}
