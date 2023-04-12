import 'package:flutter/material.dart';
import 'package:yine/main.dart';

import '../../../../models/message.dart';
import '../../../../models/profile_basic.dart';
import '../../../../models/role.dart';
import '../../../../themes/styles.dart';

class GroupMessages extends StatelessWidget {
  final List<Message> messages;
  final Map<String, Role> roles;
  final Map<String, Glance> glances;

  final ScrollController messScrollController;

  const GroupMessages({
    super.key,
    required this.messages,
    required this.roles,
    required this.glances,
    required this.messScrollController,
  });

  Container partnerMessage(Message message, bool isFirst, bool isLast) {
    return Container(
      margin: isFirst
          ? const EdgeInsets.only(top: 10, bottom: 2)
          : (isLast
              ? const EdgeInsets.only(top: 2, bottom: 10)
              : const EdgeInsets.only(top: 2, bottom: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            roles[message.sender]!.nickname == ""
                ? glances[message.sender]!.username
                : roles[message.sender]!.nickname,
            style: TextStyle(
              color: LightTheme.sprimaryColor,
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: glances[message.sender]?.avatar == ""
                      ? const AssetImage("images/user.png")
                      : NetworkImage(glances[message.sender]!.avatar)
                          as ImageProvider,
                  radius: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: LightTheme.neutralColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        message.content,
                        style: TextStyle(
                            color: LightTheme.primaryColor, fontSize: 15),
                      ),
                      Text(
                        '${message.time.day}-${message.time.month} ${message.time.hour}:${message.time.minute}',
                        style: TextStyle(
                          color: LightTheme.stertiaryColor,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container userMessage(Message message, bool isFirst, bool isLast) {
    return Container(
      child: Row(
        children: <Widget>[
          const Expanded(child: SizedBox()),
          Container(
            padding: const EdgeInsets.all(5),
            margin: isFirst
                ? const EdgeInsets.only(top: 10, bottom: 1)
                : (isLast
                    ? const EdgeInsets.only(top: 1, bottom: 10)
                    : const EdgeInsets.only(top: 1, bottom: 1)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: LightTheme.tprimaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  message.content,
                  style:
                      TextStyle(color: LightTheme.neutralColor, fontSize: 15),
                ),
                Text(
                  '${message.time.day}-${message.time.month} ${message.time.hour}:${message.time.minute}',
                  style: TextStyle(
                    color: LightTheme.sprimaryColor,
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: messages.length,
        controller: messScrollController,
        itemBuilder: (BuildContext context, int index) {
          return messages[index].sender == account.id
              ? userMessage(
                  messages[index], index == 0, index == (messages.length - 1))
              : partnerMessage(
                  messages[index], index == 0, index == (messages.length - 1));
        });
  }
}
