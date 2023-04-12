import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yine/main.dart';
import 'package:yine/models/profile_basic.dart';
import 'package:yine/network/conversation.dart';
import 'package:yine/network/message.dart';
import 'package:yine/network/profile.dart';
import 'package:yine/screens/Chat/Group/Components/messages.dart';

import '../../../models/message.dart';
import '../../../models/role.dart';
import '../../../themes/styles.dart';

class GroupChat extends StatefulWidget {
  final String conv_id;

  const GroupChat({super.key, required this.conv_id});

  @override
  _GroupChat createState() => _GroupChat();
}

class _GroupChat extends State<GroupChat> {
  dynamic group;
  Map<String, Role> members = {};
  Map<String, Glance> glances = {};
  dynamic conv_mess;

  bool isLoad = false;

  ScrollController messScrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataFromInternet();
  }

  void fetchDataFromInternet() async {
    dynamic conv_data = await fetchGroupConversation(account, widget.conv_id);
    group = conv_data["group"];
    dynamic members_data = conv_data["members"];

    for (dynamic m in members_data) {
      members[m.user] = m;
      glances[m.user] = await fetchGlance(account, m.user);
    }

    conv_mess = await fetchMessages(account, widget.conv_id);
    isLoad = true;
    setState(() {});
    scrollToEnd();
    messageStream();
  }

  void scrollToEnd() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      messScrollController
          .jumpTo(messScrollController.position.maxScrollExtent);
    });
  }

  void messageStream() async {
    WebSocket connection = await WebSocket.connect("ws://10.0.2.2:9010/c",
        headers: {'id': account.id, 'session': account.session});

    connection.listen((event) {
      Message message = Message.fromJson(jsonDecode(event));
      if (message.receiver == widget.conv_id) {
        conv_mess.add(Message.fromJson(jsonDecode(event)));
        setState(() {});
        scrollToEnd();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightTheme.secondaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: LightTheme.sprimaryColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          child: group == null
              ? const CircularProgressIndicator()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: group.avatar == ""
                          ? const AssetImage("images/group.png")
                          : NetworkImage(group.avatar) as ImageProvider,
                      radius: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        group == null ? "" : group.name,
                        style: TextStyle(
                          color: LightTheme.sprimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: LightTheme.sprimaryColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call_sharp,
                color: LightTheme.sprimaryColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                color: LightTheme.sprimaryColor,
              )),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                color: LightTheme.secondaryColor,
                child:isLoad?GroupMessages(messages: conv_mess, roles: members, glances: glances, messScrollController: messScrollController,):Container(),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: LightTheme.neutralColor,
              ),
              child: Row(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: LightTheme.sprimaryColor,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt,
                            color: LightTheme.sprimaryColor,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.image,
                            color: LightTheme.sprimaryColor,
                          )),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: LightTheme.sprimaryColor),
                            ),
                            child: TextField(
                              controller: messageController,
                              textAlignVertical: TextAlignVertical.center,
                              onTap: () {
                                scrollToEnd();
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Say something...",
                              ),
                              style: TextStyle(
                                color: LightTheme.sprimaryColor,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (messageController.text.isNotEmpty) {
                                bool sent = await sendMessage(
                                    account,
                                    widget.conv_id,
                                    "text",
                                    messageController.text);
                                if (sent) {
                                  conv_mess.add(
                                    Message(
                                        sender: account.id,
                                        receiver: widget.conv_id,
                                        type: "text",
                                        content: messageController.text,
                                        time: DateTime.now()),
                                  );
                                  setState(() {});
                                  scrollToEnd();
                                  messageController.clear();
                                }
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: LightTheme.sprimaryColor,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
