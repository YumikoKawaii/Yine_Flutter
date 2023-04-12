import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yine/models/account.dart';
import 'package:yine/models/profile.dart';
import 'package:yine/network/network_helper.dart';

//Future<http.Response> requestChangeAvatar()

Future<http.Response> requestChangeProfile(
    String id, String session, String field, String value) async {
  return await http.put(Uri.parse('$baseURL/p'), headers: {
    'id': id,
    'session': session,
  }, body: {
    'field': field,
    'value': value,
  });
}

Future<dynamic> fetchProfileData(Account account, String target) async {
  http.Response response =
      await http.get(Uri.parse('$baseURL/p/$target'), headers: {
    'id': account.id,
    'session': account.session,
  });

  if (response.statusCode == StatusCode.OK) {
    var data = jsonDecode(response.body);
    return Profile(
      id: data["id"],
      avatar: data["avatar"],
      username: data["username"],
      birthday: data["birthday"],
      address: data["address"],
      gender: data["gender"],
      hobbies: data["hobbies"],
    );
  } else {
    return null;
  }
}
