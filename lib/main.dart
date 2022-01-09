import 'dart:developer';

import 'package:axie_monitoring/database/dbhelper.dart';
import 'package:axie_monitoring/providers/marketvalprovider.dart';
import 'package:axie_monitoring/providers/userprovider.dart';
import 'package:axie_monitoring/views/screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  log("called in main");
  await DatabaseHelper.instance.deleteDb();
  await DatabaseHelper.instance.initDb();
  log("finished");
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<PlayersProvider>(
          create: (_) => PlayersProvider(),
          dispose: (_, provider) => provider.dispose(),
        ),
        ListenableProvider<MarketValProvider>(
          create: (_) => MarketValProvider(),
          dispose: (_, provider) => provider.closeCron(),
        ),
      ],
      child: MaterialApp(
        title: 'Axie Monitoring',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          cardTheme: CardTheme(
            elevation: 5,
            shadowColor: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
