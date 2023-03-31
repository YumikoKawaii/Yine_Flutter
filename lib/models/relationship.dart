import 'package:sqflite/sqflite.dart';
import 'package:yine/main.dart';

class Relationship {

  String id;
  String guest;
  String status;

  Relationship({required this.id, required this.guest, required this.status});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'guest': guest,
      'status': status,
    };
  }

  factory Relationship.fromJson(Map<String, dynamic> json) {
    return Relationship(
        id: json['id'] as String,
        guest: json['guest'] as String,
        status: json['status'] as String,
    );
  }

}

Future<void> insertRelationship(Relationship relationship) async {
  await database.insert('relationships', relationship.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<String>> getFriends() async {
  var raw = await database.rawQuery("select guest from relationships where status = \"friend\"");

  if (raw == []) {
    return [];
  }

  List<String> result = [];
  for (int i = 0;i < raw.length;i++) {
    result.add(raw[i]['guest']);
  }

  return result;

}