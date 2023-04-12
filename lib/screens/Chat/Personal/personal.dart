import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yine/main.dart';
import 'package:yine/network/conversation.dart';
import 'package:yine/network/message.dart';
import 'package:yine/network/profile.dart';
import 'package:yine/screens/Chat/Personal/Components/messages.dart';

import '../../../models/message.dart';
import '../../../themes/styles.dart';

class PersonalChat extends StatefulWidget {
  static String id = "personal_chat";
  final String conv_id;

  const PersonalChat({super.key, required this.conv_id});

  @override
  _PersonalChat createState() => _PersonalChat();
}

class _PersonalChat extends State<PersonalChat> {
  dynamic user;
  dynamic userRole;
  dynamic partner;
  dynamic partnerRole;

  dynamic conv_mess;
  String conv_name = "";

  ScrollController messScrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataFromInternet();
  }

  void fetchDataFromInternet() async {
    dynamic conv_data =
        await fetchPersonalConversation(account, widget.conv_id);
    userRole = conv_data["user"];
    partnerRole = conv_data["partner"];
    partner = await fetchGlance(account, widget.conv_id);

    print(widget.conv_id);

    if (partnerRole.nickname == "") {
      conv_name = partner.username;
      if (conv_name.length > 8) conv_name = "${conv_name.substring(0, 7)}...";
    }

    setState(() {});

    conv_mess = await fetchMessages(account, widget.conv_id);

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
          child: partner == null
              ? const CircularProgressIndicator()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: partner.avatar == ""
                          ? const AssetImage("images/user.png")
                          : NetworkImage(partner.avatar) as ImageProvider,
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
                      : PersonalMessages(
                          messages: conv_mess,
                          messScrollController: messScrollController),
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
