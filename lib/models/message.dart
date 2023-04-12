import 'package:sqflite/sqflite.dart';
import 'package:yine/main.dart';

class Message {

  String sender;
  String receiver;
  String type;
  String content;
  DateTime time;

  Message({
    required this.sender,
    required this.receiver,
    required this.type,
    required this.content,
    required this.time,
  });

  Map<String, dynamic> toMap(){
    return {
      'sender': sender,
      'coid': receiver,
      'type': type,
      'content': content,
      'time': time,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        sender: json['sender'] as String,
        receiver: json['receiver'] as String,
        type: json['type'] as String,
        content: json['content'] as String,
        time: DateTime.parse(json["Time"]),
    );
  }

}