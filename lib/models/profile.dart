import 'package:sqflite/sqflite.dart';
import 'package:yine/main.dart';

class Profile {

  String id;
  String avatar;
  String username;
  String birthday;
  String address;
  String gender;
  String hobbies;

  Profile({
    required this.id,
    required this.avatar,
    required this.username,
    required this.birthday,
    required this.address,
    required this.gender,
    required this.hobbies,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avatar': avatar,
      'username': username,
      'birthday': birthday,
      'address': address,
      'gender': gender,
      'hobbies': hobbies,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      avatar: json['avatar'] as String,
      username: json['username'] as String,
      birthday: json['birthday'] as String,
      address: json['address'] as String,
      gender: json['gender'] as String,
      hobbies: json['hobbies'] as String,
    );
  }

}

Future<void> insertProfile(Profile profile) async {
  await database.insert('profiles', profile.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<Profile> getProfile(String id) async {
  var result = await database.rawQuery("select * from profiles where id = \"$id\"");

  if (result == []) {
    return Profile(
        id: "", avatar: "", username: "", birthday: "", address: "", gender: "", hobbies: ""
    );
  }

  var item = result[0];

  return Profile(
    id: item['id'] as String,
    avatar: item['avatar'] as String,
    username: item['username'] as String,
    birthday: item['birthday'] as String,
    address: item['address'] as String,
    gender: item['gender'] as String,
    hobbies: item['hobbies'] as String,
  );
}

Future<List<Profile>> getFriendProfiles(String id) async {

  var raw = await database.rawQuery("select * from profiles where id <> \"$id\"");
  if (raw == []) return [];
  List<Profile> result = [];
  for (int i = 0;i < raw.length;i++) {
    result.add(Profile.fromJson(raw[i]));
  }
  return result;
}