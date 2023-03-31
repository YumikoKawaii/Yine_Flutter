import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yine/main.dart';
import 'package:yine/models/account.dart';
import 'package:yine/models/profile.dart';
import 'package:yine/models/relationship.dart';
import 'package:yine/network/network_helper.dart';
import 'package:yine/network/profile.dart';
import 'package:yine/network/relationship.dart';
import 'package:yine/screens/main_nav.dart';
import 'package:yine/screens/welcome.dart';

import 'package:yine/themes/styles.dart';

Map<int, String> migrationScripts = {
  1: "CREATE TABLE accounts (id TEXT PRIMARY KEY, session TEXT)",
  2: "CREATE TABLE profiles (id TEXT PRIMARY KEY, avatar TEXT, username TEXT, birthday TEXT, address TEXT, gender TEXT, hobbies TEXT)",
  3: "CREATE TABLE relationships (id TEXT, guest TEXT, status TEXT)",
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
    WidgetsFlutterBinding.ensureInitialized();
    initDatabase();
    super.initState();
  }

  Future<void> initDatabase() async {

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

    account = await getAccount();
    if (account.id == "") {
      Navigator.pushNamed(this.context, Welcome.id);
    } else {
      Navigator.pushNamed(this.context, MainNav.id);
    }

    var rltsData = await fetchRelationships(account);
    if (rltsData.statusCode == StatusCode.OK) {
      var list = json.decode(rltsData.body);
      for (int i = 0;i < list.length;i++) {
        await insertRelationship(Relationship(
          id: list[i]['user'] as String,
          guest: list[i]['guest'] as String,
          status: list[i]['status'] as String,
        ));
      }
    }

    List<String> fid = await getFriends();
    await fetchFriendData(fid);

  }

  Future<void> fetchFriendData(List<String> fid) async {

    for (int i = 0;i < fid.length;i++) {
      var res = await fetchProfileData(account, fid[i]);
      if (res.statusCode == StatusCode.OK) {
          await insertProfile(Profile.fromJson(jsonDecode(res.body)));
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.secondaryColor,
      body: Center(
        child: Expanded(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 220,
                  width: 240,
                  decoration: BoxDecoration(
                    color: LightTheme.primaryColor,
                    borderRadius: BorderRadius.circular(40)
                  ),
                ),
              ),
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
          ),
        )
      ),
      );
  }
}