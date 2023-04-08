import 'package:yine/main.dart';
import 'package:sqflite/sqflite.dart';

class Group {

  String gid;
  String avatar;
  String name;

  Group({
    required this.gid,
    required this.avatar,
    required this.name
  });

  Map<String, dynamic> toMap() {
    return {
      'gid': gid,
      'avatar': avatar,
      'name': name
    };
  }

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        gid: json['gid'] as String,
        avatar: json['avatar'] as String,
        name: json['name'] as String
    );
  }

}