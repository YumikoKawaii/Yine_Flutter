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
  var result = await database.rawQuery("select * from profiles where id = ?", id);

  if (result == null) {
    return Profile(
        id: "", avatar: "", username: "", birthday: "", address: "", gender: "", hobbies: ""
    );
  }

  return Profile(
    id: result['id'] as String,
    avatar: result['avatar'] as String,
    username: result['username'] as String,
    birthday: result['birthday'] as String,
    address: result['address'] as String,
    gender: result['gender'] as String,
    hobbies: result['hobbies'] as String,
  );
}