import 'package:axie_monitoring/database/driftdb.dart';
import 'package:drift/backends.dart';
export 'shared.dart';

class DriftDbHelper {
  DriftDbHelper._();

  static DriftDbHelper? _instance;

  static DriftDbHelper get instance {
    _instance ??= DriftDbHelper._();
    return _instance!;
  }

  static AxieDatabase db = AxieDatabase(Platform.createDatabaseConnection());

  close() {
    db.close();
  }

  final PlayerDao playerDao = PlayerDao(db);
  final UserDao userDao = UserDao(db);
}

class Platform {
  static QueryExecutor createDatabaseConnection() =>
      PlatformInterface.openConnection();
}
