import 'package:axie_monitoring/constants.dart';
import 'package:axie_monitoring/providers/marketvalprovider.dart';
import 'package:axie_monitoring/providers/driftuserprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,###.##", "en_US");
    return Card(
      color: Colors.indigo.shade200,
      child: SizedBox(
        width: CardSize.width,
        height: CardSize.height,
        child: Consumer2<PlayersProvider, MarketValProvider>(
            builder: (context, playersProvider, marketValProvider, child) {
          return playersProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "TOTAL",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        alignment: Alignment.centerLeft,
                        // color: Colors.red,
                        child: Text(
                          "SLP: ${oCcy.format(playersProvider.totalSlp)}",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        alignment: Alignment.centerLeft,
                        // color: Colors.red,
                        child: SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "PHP ${oCcy.format(playersProvider.totalSlp * marketValProvider.slpMarketVal)}",
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "SLP MARKET VALUE: ${marketValProvider.slpMarketVal}",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
