import 'dart:developer';

import 'package:axie_monitoring/api/slpmarketvalue.dart';
import 'package:flutter/material.dart';
import 'package:cron/cron.dart';

class MarketValProvider extends ChangeNotifier{

  final _cron = Cron();
  double _slpMarketVal = 0;

  double get slpMarketVal => _slpMarketVal;

  MarketValProvider(){
    // _databaseHelper.createUser(_user);
    fetchSlpMarketValue();
    updateSlpMarketValue();
  }

  void updateSlpMarketValue() {
    //fetch data every one hour
    _cron.schedule(Schedule.parse("0 * * * *"), () async {
      _slpMarketVal = await MarketAPIHelper.fetchSlpMarketValue();
      log("Updated SLP Market Value: " + slpMarketVal.toString());
      notifyListeners();
    });
  }
  void fetchSlpMarketValue()async {
    _slpMarketVal = await MarketAPIHelper.fetchSlpMarketValue();
    notifyListeners();
  }
  void closeCron() {
    _cron.close();
  }
}