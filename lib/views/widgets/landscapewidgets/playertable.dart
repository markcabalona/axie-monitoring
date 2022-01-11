import 'package:axie_monitoring/models/player.dart';
import 'package:axie_monitoring/providers/driftuserprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PlayerTable extends StatelessWidget {
  const PlayerTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayersProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(180),
              1: FixedColumnWidth(240),
              2: FixedColumnWidth(240),
              3: FixedColumnWidth(240),
              4: FixedColumnWidth(240),
              5: FixedColumnWidth(240),
              6: FixedColumnWidth(300),
            },
            border: TableBorder.all(),
            defaultColumnWidth: const FlexColumnWidth(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              const TableRow(
                //headers
                children: [
                  Center(
                    heightFactor: 2,
                    child: Text(
                      "Name",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Total SLP",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Today SLP",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Yesterday SLP",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Average SLP",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Claimable SLP",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "LastClaimed At",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              ...buildRows(provider.players),
            ]),
      );
    });
  }

  List<TableRow> buildRows(List<Player> players) {
    return List<TableRow>.generate(
      players.length,
      (index) {
        DateTime? lastClaimedAt = players[index].slp.lastClaimedItemAt;
        return TableRow(
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
          ),
          children: [
            ListTile(
              title: Text(
                players[index].name,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                players[index].slp.total.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                players[index].slp.todaySoFar.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                players[index].slp.yesterdaySLP.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                players[index].slp.average.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                players[index].slp.claimableTotal.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                lastClaimedAt == null
                    ? "N/A"
                    : DateFormat('MMMM d y - kk:mm').format(lastClaimedAt),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
