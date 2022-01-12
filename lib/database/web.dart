

import 'package:drift/backends.dart';
import 'package:drift/web.dart';



class PlatformInterface{
  static QueryExecutor openConnection(){
  return WebDatabase('db',logStatements: true);
}
}