import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yine/main.dart';
import 'package:yine/screens/welcome.dart';

import 'package:yine/themes/styles.dart';

Map<int, String> migrationScripts = {
  1: '''CREATE TABLE accounts (id STRING PRIMARY KEY, session STRING)'''
};

class StartUp extends StatefulWidget {

  static String id = "startup";

  const StartUp({super.key});

  @override
  _StartUp createState() => _StartUp();
}

class _StartUp extends State<StartUp> {

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    initDatabase();
  }

  void initDatabase() async {

    database = await openDatabase(
      join(await getDatabasesPath(), 'yine.db'),
      version: migrationScripts.length,
      onCreate: (Database db, int version) async {
        for (int i = 1;i <= migrationScripts.length;i++) {
          await db.execute(migrationScripts[i]!);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (int i = oldVersion + 1;i <= newVersion;i++) {
          await db.execute(migrationScripts[i]!);
        }
      },
    );

    Navigator.pushNamed(this.context, Welcome.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.secondaryColor,
      body: Center(
        child: Stack(
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('images/message.png'),
                height: 200,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "YINE",
                  style: TextStyle(
                      color: LightTheme.primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )
      ),
      );
  }
}