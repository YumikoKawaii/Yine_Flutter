import 'package:flutter/material.dart';
import 'package:yine/main.dart';

import 'package:yine/models/message.dart';
import 'package:yine/themes/styles.dart';

class PersonalMessages extends StatelessWidget {
  final List<Message> messages;
  final ScrollController messScrollController;

  const PersonalMessages(
      {super.key, required this.messages, required this.messScrollController});

  Container partnerMessage(Message message, bool isLast, bool isFirst) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(5),
            margin:  isFirst? const EdgeInsets.only(top: 10, bottom: 1):(isLast?const EdgeInsets.only(top: 1, bottom: 10):const EdgeInsets.only(top: 1, bottom: 1)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: LightTheme.neutralColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message.content,
                  style:
                      TextStyle(color: LightTheme.primaryColor, fontSize: 15),
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
    );
  }

  Container userMessage(Message message, bool isLast, bool isFirst) {
    return Container(
      child: Row(
        children: <Widget>[
          const Expanded(child: SizedBox()),
          Container(
            padding: const EdgeInsets.all(5),
            margin: isFirst? const EdgeInsets.only(top: 10, bottom: 1):(isLast?const EdgeInsets.only(top: 1, bottom: 10):const EdgeInsets.only(top: 1, bottom: 1)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: LightTheme.tprimaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  message.content,
                  style: TextStyle(color: LightTheme.neutralColor, fontSize: 15),
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
              ? userMessage(messages[index], index == (messages.length - 1), index == 0)
              : partnerMessage(messages[index], index == (messages.length - 1), index == 0);
        });
  }
}
