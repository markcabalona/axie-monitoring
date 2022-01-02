import 'dart:developer';

import 'package:axie_monitoring/constants.dart';
import 'package:axie_monitoring/models/player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({Key? key, required this.player}) : super(key: key);
  final Player player;
  @override
  Widget build(BuildContext context) {
    DateTime? lastClaimedAt = player.slp.lastClaimedItemAt;
    return Card(
      elevation: 5,
      child: InkWell(
        hoverColor: Colors.indigo.shade200.withOpacity(.2),
        splashColor: Colors.indigo.shade200.withOpacity(.3),
        focusColor: Colors.indigo.shade200.withOpacity(.5),
        highlightColor: Colors.indigo.shade200.withOpacity(.5),
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          log("Player Card Clicked");
        },
        child: SizedBox(
          width: CardSize.width,
          height: CardSize.height,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  player.name,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      // width: 200,
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "Scholar: ${player.slp.total * player.percentage}",
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "Manager: ${player.slp.total * (1 - player.percentage)}",
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              "Total Slp: ${player.slp.total}",
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.start,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      // width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Average"),
                          Text(
                            player.slp.average.toString(),
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                // height: 25,
                // padding: const EdgeInsets.all(5),
                child: Text(
                  lastClaimedAt == null
                      ? "Last Claimed At: N/A"
                      : "Last Claimed At: " +
                          DateFormat('MMMM d y - kk:mm').format(lastClaimedAt),
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
