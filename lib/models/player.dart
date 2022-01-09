import 'package:axie_monitoring/api/fetchslpstats.dart';
import 'package:axie_monitoring/database/player.dart';
import 'package:axie_monitoring/models/slp.dart';

class Player {
  int? id;
  int? userId;
  String roninId;
  String name;
  double percentage;
  late SlpStats slp;

  Player({
    required this.roninId,
    required this.name,
    required this.percentage,
  });

  Map<String, dynamic> toMap() => {
        PlayerTableFields.roninId: roninId,
        PlayerTableFields.name: name,
        PlayerTableFields.percentage: percentage,
      };

  Player.fromMap(Map<String, dynamic> map)
      : id = map[PlayerTableFields.id],
        roninId = map[PlayerTableFields.roninId],
        name = map[PlayerTableFields.name],
        percentage = map[PlayerTableFields.percentage],
        userId = map[PlayerTableFields.userId];

  void update() async {
    slp = await AxieApiHelper.fetchSlpStats(roninId);
  }
}
