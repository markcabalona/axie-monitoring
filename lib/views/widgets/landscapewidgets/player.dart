import 'package:flutter/material.dart';
import 'package:axie_monitoring/models/player.dart' as models;

class Player extends StatelessWidget {
  final models.Player player;

  const Player({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 80,
            child: ListTile(
              title: Text(player.name),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 80,
            child: ListTile(
              title: Text(player.slp.todaySoFar.toString()),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 80,
            child: ListTile(
              title: Text(player.slp.yesterdaySLP.toString()),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 80,
            child: ListTile(
              title: Text(player.slp.average.toString()),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 500,
            child: ListTile(
              title: Text(player.slp.lastClaimedItemAt.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
