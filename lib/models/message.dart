import 'package:sqflite/sqflite.dart';
import 'package:yine/main.dart';

class Message {

  String sender;
  String coid;
  String type;
  String content;
  String status;

  Message({
    required this.sender,
    required this.coid,
    required this.type,
    required this.content,
    required this.status,
  });

  Map<String, dynamic> toMap(){
    return {
      'sender': sender,
      'coid': coid,
      'type': type,
      'content': content,
      'status': status,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        sender: json['sender'] as String,
        coid: json['coid'] as String,
        type: json['type'] as String,
        content: json['content'] as String,
        status: json['status'] as String
    );
  }

}

Future<void> insertMessage(Message message) async {
  await database.insert('messages', message.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Message>> getMessages(String coid) async {

  var result = database.rawQuery("select * from messages where coid = \"$coid\"");
  print(result);
  return [];
}