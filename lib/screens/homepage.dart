import 'package:flutter/material.dart';
import 'package:yine/main.dart';
import 'package:yine/models/account.dart';
import 'package:yine/models/profile.dart';
import 'package:yine/models/relationship.dart';
import 'package:yine/themes/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  _Home createState() => _Home();
}

class FriendItem {
  FriendItem({
    required this.avt,
    required this.username,
  });

  String avt;
  String username;
}

class _Home extends State<Home> {
  dynamic profile;
  dynamic friendList;

  bool groupExpanded = false;
  bool friendExpanded = false;

  @override
  void initState() {
    getDataFromDatabase();
    super.initState();
  }

  void getDataFromDatabase() async {
    profile = await getProfile(account.id);
    friendList = await getFriendProfiles(account.id);
    print(friendList[0].id);
    setState(() {});
  }

  Expanded serviceTemplate(String field, IconData iconData) {
    return Expanded(
        child: OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: LightTheme.secondaryColor,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        side: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 5),
        child: Column(
          children: <Widget>[
            Icon(
              iconData,
              size: 35,
              color: LightTheme.sprimaryColor,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                field,
                style: TextStyle(
                  color: LightTheme.sprimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme.secondaryColor,
        actions: <Widget>[
          IconButton(
              onPressed: () {},
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("images/user.png"),
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
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      serviceTemplate("Stickers", Icons.smart_toy),
                      serviceTemplate("Themes", Icons.color_lens),
                      serviceTemplate("Official", Icons.local_police),
                      serviceTemplate("Games", Icons.videogame_asset),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        switch (index) {
                          case 0:
                            {
                              groupExpanded = !isExpanded;
                            }
                            break;
                          case 1:
                            {
                              friendExpanded = !isExpanded;
                            }
                            break;
                        }
                      });
                    },
                    elevation: 0,
                    dividerColor: Colors.transparent,
                    children: [
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              "Groups",
                              style: TextStyle(
                                color: LightTheme.sprimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        backgroundColor: Colors.transparent,
                        body: Container(
                          child: Column(
                            children: <Widget>[],
                          ),
                        ),
                        isExpanded: groupExpanded,
                        canTapOnHeader: true,
                      ),
                      ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(
                              "Friends",
                              style: TextStyle(
                                color: LightTheme.sprimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        backgroundColor: Colors.transparent,
                        body: Container(
                          child: Column(
                            children: [

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
                                            foregroundColor:
                                                LightTheme.secondaryColor,
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
                        isExpanded: friendExpanded,
                        canTapOnHeader: true,
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
