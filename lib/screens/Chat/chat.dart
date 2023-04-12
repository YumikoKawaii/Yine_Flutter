import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:yine/main.dart';
import 'package:yine/models/message.dart';
import 'package:yine/network/conversation.dart';
import 'package:yine/network/message.dart';
import 'package:yine/network/profile.dart';
import 'package:yine/screens/Chat/Components/Personal/messages.dart';
import 'package:yine/themes/styles.dart';

class Chat extends StatefulWidget {
  static String id = "chat";
  final String conv_id;

  const Chat({super.key, required this.conv_id});

  @override
  _Chat createState() => _Chat();
}

class _Chat extends State<Chat> {
  dynamic conv_data;

  late String conv_name;
  late String conv_avatar;
  dynamic user;
  dynamic userRole;
  dynamic partners;
  dynamic partnerRoles;
  dynamic conv_mess;

  ScrollController messScrollController = ScrollController();

  var messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataFromInternet();
  }

  void fetchDataFromInternet() async {
    conv_data = await fetchDetailConversation(account, widget.conv_id);

    if (conv_data["type"] == "personal") {
      userRole = conv_data["user"];
      partnerRoles = conv_data["partner"];
      user = await fetchProfileData(account, userRole.user);
      partners = await fetchProfileData(account, partnerRoles.user);

      partnerRoles.nickname == ""
          ? conv_name = partners.username
          : conv_name = partners.nickname;

      if (conv_name.length > 8) {
        conv_name = "${conv_name.substring(0, 7)}...";
      }

      conv_avatar = partners.avatar;
    }

    setState(() {});

    conv_mess = await fetchMessages(account, widget.conv_id);

    scrollToEnd();

    setState(() {});
    messageStream();
  }

  void messageStream() async {
    WebSocket connection = await WebSocket.connect("ws://10.0.2.2:9010/c",
        headers: {'id': account.id, 'session': account.session});

    connection.listen((event) {
      conv_mess.add(Message.fromJson(jsonDecode(event)));
      setState(() {});
      scrollToEnd();
    });
  }

  void scrollToEnd() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      messScrollController
          .jumpTo(messScrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightTheme.secondaryColor,
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
          child: partners == null
              ? const CircularProgressIndicator()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: conv_avatar == ""
                          ? const AssetImage("images/user.png")
                          : NetworkImage(conv_avatar) as ImageProvider,
                      radius: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        conv_name,
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
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  alignment: Alignment.topCenter,
                  child: conv_mess == null
                      ? Container()
                      : (conv_data["type"] == "personal"
                          ? PersonalMessages(
                              messages: conv_mess,
                              messScrollController: messScrollController,
                            )
                          : Container()),
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
      ),
    );
  }
}
