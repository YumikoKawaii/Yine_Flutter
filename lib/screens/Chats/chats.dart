import 'package:flutter/material.dart';
import 'package:yine/main.dart';
import 'package:yine/models/conversation.dart';
import 'package:yine/network/conversation.dart';
import 'package:yine/screens/Chats/Components/conversations.dart';
import 'package:yine/themes/styles.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  _Chats createState() => _Chats();
}

class _Chats extends State<Chats> {
  dynamic conversations;

  @override
  void initState() {
    getDataFromInternet();
    super.initState();
  }

  void getDataFromInternet() async {
    var cids = await fetchConversations(account);
    conversations = <Conversation>[];
    for (String cid in cids) {
      var t = await fetchBasicInfoConversation(account, cid);
      conversations.add(t);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme.secondaryColor,
        title: Text(
          "Chats",
          style: TextStyle(
            color: LightTheme.sprimaryColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: ImageIcon(
                const AssetImage("images/chat.png"),
                color: LightTheme.stertiaryColor,
                size: 22,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: LightTheme.stertiaryColor,
              )),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: Column(
            children: <Widget>[
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
              Expanded(
                  child: conversations == null
                      ? const CircularProgressIndicator()
                      : ConversationList(convs: conversations)),
            ],
          ),
        ),
      ),
    );
  }
}
