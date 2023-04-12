import 'package:flutter/material.dart';
import 'package:yine/screens/Chat/chat.dart';
import 'package:yine/themes/styles.dart';

import '../../../models/conversation.dart';

class ConversationList extends StatelessWidget {
  const ConversationList({super.key, required this.convs});

  final List<Conversation> convs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: convs.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(conv_id: convs[index].conv_id)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: convs[index].conv_avatar == ""
                        ? const AssetImage("images/user.png")
                        : NetworkImage(convs[index].conv_avatar)
                            as ImageProvider,
                    radius: 35,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              convs[index].conv_name,
                              style: TextStyle(
                                  color: LightTheme.sprimaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              convs[index].lastest_message,
                              style: TextStyle(
                                color: LightTheme.stertiaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Text("${convs[index].recent.hour}:${convs[index].recent.minute}",
                      style: TextStyle(
                        color: LightTheme.stertiaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
