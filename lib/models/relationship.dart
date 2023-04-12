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
