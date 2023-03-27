import 'package:flutter/material.dart';
import 'package:yine/themes/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});



  _Home createState() => _Home();
}

class _Home extends State<Home> {

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
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme.primaryColor,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.bookmark, color: LightTheme.stertiaryColor,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications, color: LightTheme.stertiaryColor,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person_add_alt_1, color: LightTheme.stertiaryColor,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: LightTheme.stertiaryColor,)),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage("https://scontent.fhan14-4.fna.fbcdn.net/v/t39.30808-6/336397217_170823475775975_2908837610903461249_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=cfNVzGGMvv8AX9r-3S9&_nc_ht=scontent.fhan14-4.fna&oh=00_AfCArJHwLlnilDdGKl93zlL-3bS7_1Uy3WSQXPJXdLURnA&oe=642522D3"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Yumiko Sturluson",
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
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Groups",
                    style: TextStyle(
                    color: LightTheme.sprimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Friends",
                    style: TextStyle(
                      color: LightTheme.sprimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
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
                          )
                        ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}