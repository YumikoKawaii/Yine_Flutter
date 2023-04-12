import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yine/models/account.dart';
import 'package:yine/network/network_helper.dart';

String baseURL = "http://10.0.2.2:9010";

Future<dynamic> fetchFriends(Account account) async {

  http.Response response = await http.get(
    Uri.parse('$baseURL/rlts'),
    headers: {
      'id': account.id,
      'session': account.session,
    }
  );

  if (response.statusCode == StatusCode.OK) {
    var data = jsonDecode(response.body);
    var friends = <String>[];
    for (int i = 0;i < data.length;i++) {
      if (data[i]["status"] == "friend") {
        friends.add(data[i]["guest"]);
      }
    }
    return friends;
  } else {
    return null;
  }

}