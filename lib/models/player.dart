import 'package:axie_monitoring/api/fetchslpstats.dart';
import 'package:axie_monitoring/models/slp.dart';

class Player {
  String roninId;
  String name;
  double percentage; //initialize to 100
  late SlpStats slp;
  // Future<LeaderboardStats>? leaderboard;
  // Future<Adventure>? adventure;

  Player({
    required this.roninId,
    required this.name,
    required this.percentage,
  });

  void update()async{
    slp = await ApiHelper.fetchSlpStats(roninId);
  }
}
