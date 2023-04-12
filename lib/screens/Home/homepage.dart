import 'package:flutter/material.dart';
import 'package:yine/main.dart';
import 'package:yine/models/account.dart';
import 'package:yine/models/profile.dart';
import 'package:yine/models/relationship.dart';
import 'package:yine/network/profile.dart';
import 'package:yine/network/relationship.dart';
import 'package:yine/screens/Home/Components/friendlist.dart';
import 'package:yine/screens/Home/Components/service.dart';
import 'package:yine/themes/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  _Home createState() => _Home();
}

class _Home extends State<Home> {
  dynamic profile;
  dynamic friendList;

  bool groupExpanded = false;
  bool friendExpanded = false;

  @override
  void initState() {
    getDataFromInternet();
    super.initState();
  }

  void getDataFromInternet() async {
    profile = await fetchProfileData(account, account.id);
    var friendIds = await fetchFriends(account);
    friendList = <Profile>[];
    for (String id in friendIds) {
      var p = await fetchProfileData(account, id);
      friendList.add(p);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme.secondaryColor,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print(account.id);
                print(account.session);
              },
              icon: Icon(
                Icons.bookmark,
                color: LightTheme.stertiaryColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: LightTheme.stertiaryColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person_add_alt_1,
                color: LightTheme.stertiaryColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: LightTheme.stertiaryColor,
              )),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profile == null
                            ? const AssetImage("images/user.png")
                            : NetworkImage(profile.avatar) as ImageProvider,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          profile == null
                              ? "profile.username"
                              : profile.username,
                          style: TextStyle(
                            color: LightTheme.sprimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightTheme.stertiaryColor,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: const <Widget>[
                        Icon(Icons.search),
                        Text("Search"),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Services",
                      style: TextStyle(
                        color: LightTheme.sprimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: const <Widget>[
                      Service(iconData: Icons.smart_toy, field: "Stickers"),
                      Service(iconData: Icons.color_lens, field: "Themes"),
                      Service(iconData: Icons.local_police, field: "Official"),
                      Service(iconData: Icons.videogame_asset, field: "Games"),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.all(0),
                    title: Text(
                      "Groups",
                      style: TextStyle(
                        color: LightTheme.sprimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    children: [],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    tilePadding: const EdgeInsets.all(0),
                    title: Text(
                      "Friends",
                      style: TextStyle(
                        color: LightTheme.sprimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: friendList == null
                              ? const CircularProgressIndicator()
                              : FriendList(friendList: friendList)),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Ready to add friends?",
                              style: TextStyle(
                                color: LightTheme.sprimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    foregroundColor: LightTheme.secondaryColor,
                                    side: BorderSide(
                                      color: LightTheme.ssecondaryColor,
                                      width: 1,
                                    )),
                                child: Text(
                                  "Add friends",
                                  style: TextStyle(
                                    color: LightTheme.sprimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
