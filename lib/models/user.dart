import 'package:axie_monitoring/database/user.dart';
import 'package:axie_monitoring/models/player.dart';

class User {
  late int id;
  String name;
  String username;
  String password;
  List<Player> players = [];

  User({
    required this.name,
    required this.username,
    required this.password,
  });

  User.fromMap(Map<String, dynamic> map)
      : id = map[UserTableFields.id],
        name = map[UserTableFields.name],
        username = map[UserTableFields.username],
        password = map[UserTableFields.password];

  Map<String, dynamic> toMap() => {
        UserTableFields.name: name,
        UserTableFields.username: username,
        UserTableFields.password: password,
      };
}
