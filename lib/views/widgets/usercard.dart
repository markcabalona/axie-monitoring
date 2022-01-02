import 'package:axie_monitoring/constants.dart';
import 'package:axie_monitoring/providers/playersprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0.00", "en_US");
    return Consumer<PlayersProvider>(
      builder: (context, provider, child) => Card(
        color: Colors.indigo.shade200,
        child: SizedBox(
          width: CardSize.width,
          height: CardSize.height,
          child: Column(
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
                    "SLP: ${oCcy.format(provider.totalSlp)}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  alignment: Alignment.centerLeft,
                  // color: Colors.red,
                  child: Text(
                    "PHP ${oCcy.format(provider.totalSlp * 1.3)}",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
