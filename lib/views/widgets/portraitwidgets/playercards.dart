import 'package:axie_monitoring/providers/userprovider.dart';
import 'package:axie_monitoring/views/widgets/portraitwidgets/playercard.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerCards extends StatelessWidget {
  const PlayerCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayersProvider>(builder: (context, provider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List<PlayerCard>.generate(
            provider.players.length,
            (index) => PlayerCard(
              player: provider.players[index],
            ),
          )
        ],
      );
    });
  }
}
