

import 'package:axie_monitoring/database/driftdb.dart';

class DriftDbHelper{
  DriftDbHelper._();

  static DriftDbHelper? _instance;

  static DriftDbHelper get instance {
    _instance ??= DriftDbHelper._();
    return _instance!;
  }

  static AxieDatabase db = AxieDatabase();

  close(){
    db.close();
  }

  final PlayerDao playerDao = PlayerDao(db);
  final UserDao userDao = UserDao(db);


}