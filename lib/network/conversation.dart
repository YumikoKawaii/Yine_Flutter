import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yine/models/account.dart';
import 'package:yine/models/conversation.dart';
import 'package:yine/models/role.dart';
import 'package:yine/network/network_helper.dart';

Future<dynamic> fetchConversations(Account account) async {
  http.Response response = await http.get(Uri.parse('$baseURL/cvs'), headers: {
    'id': account.id,
    'session': account.session,
  });

  if (response.statusCode == StatusCode.OK) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}

Future<dynamic> fetchBasicInfoConversation(Account account, String target) async {
  http.Response response = await http.get(Uri.parse('$baseURL/cvs/$target'),
      headers: {'id': account.id, 'session': account.session});

  if (response.statusCode == StatusCode.OK) {
    var data = jsonDecode(response.body);
    if (data["type"] == "group") {
      return null;
    } else {
      return Conversation(
        conv_id: target,
        conv_name: data["name"],
        conv_avatar: data["avatar"],
        lastest_message: data["lastest"],
        recent: DateTime.parse(data["recent"]),
        newMessage: 2
      );
    }
  } else {
    return null;
  }
}

Future<dynamic> fetchDetailConversation(Account account, String target) async {

  http.Response response = await http.get(Uri.parse('$baseURL/cvs/d/$target'),
      headers: {'id': account.id, 'session': account.session});

  if (response.statusCode == StatusCode.OK) {

    var data = jsonDecode(response.body);
    if (data["type"] == "group") {
      return null;
    } else {
      var partner = Role.fromJSon(data["partner"]);
      var user = Role.fromJSon(data["user"]);
      return {
        'type': "personal",
        'user': user,
        'partner': partner,
      };
    }

  } else {
    return null;
  }

}
