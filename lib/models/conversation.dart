import 'package:yine/main.dart';
import 'package:sqflite/sqflite.dart';

class Conversation {
  String user;
  String coid;
  String role;
  String nickname;
  String status;

  Conversation({
    required this.user,
    required this.coid,
    required this.role,
    required this.nickname,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'coid': coid,
      'role': role,
      'nickname': nickname,
      'status': status
    };
  }

  factory Conversation.fromJSon(Map<String, dynamic> json) {
    return Conversation(
      user: json['user'] as String,
      coid: json['coid'] as String,
      role: json['role'] as String,
      nickname: json['nickname'] as String,
      status: json['status'] as String,
    );
  }
}


Future<void> insertConversation(Conversation conversation) async {

  await database.insert('conversations', conversation.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

}

Future<Conversation> getConversation(String user, String coid) async {

  var result = await database.rawQuery("select * from conversations where user = \"$user\" and coid = \"$coid\"");

  return Conversation.fromJSon(result);

}
