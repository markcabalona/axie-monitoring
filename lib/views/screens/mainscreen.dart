import 'package:axie_monitoring/providers/playersprovider.dart';
import 'package:axie_monitoring/views/widgets/addplayer.dart';
import 'package:axie_monitoring/views/widgets/playercards.dart';
import 'package:axie_monitoring/views/widgets/playertable.dart';
import 'package:axie_monitoring/views/widgets/usercard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Axie Monitoring"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            splashRadius: 20,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            //user's card
            const UserCard(),
            //players list aka scholars
            Container(
              padding: EdgeInsets.symmetric(
                horizontal:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 50
                        : 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Consumer<PlayersProvider>(
                      builder: (context, provider, child) => Container(
                        child: Text(
                          "Scholars(${provider.players.length})",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        splashRadius: 20,
                        icon: const Icon(Icons.person_add),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AddPlayer();
                            },
                          );
                        },
                        // child: const Text("Add Scholar to Monitor"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.topCenter,
              child: MediaQuery.of(context).orientation == Orientation.landscape
                  ? const PlayerTable()
                  : const PlayerCards(),
            ),
          ],
        ),
      ),
    );
  }
}
