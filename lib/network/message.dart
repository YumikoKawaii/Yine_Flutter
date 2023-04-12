import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yine/models/account.dart';
import 'package:yine/models/message.dart';
import 'package:yine/network/network_helper.dart';

Future<dynamic> fetchMessages(Account account, String conv_id) async {
  http.Response response =
      await http.get(Uri.parse('$baseURL/m/$conv_id'), headers: {
    'id': account.id,
    'session': account.session,
  });

  if (response.statusCode == StatusCode.OK) {
    var data = jsonDecode(response.body);
    List<Message> result = <Message>[];
    for (dynamic i in data) {
      result.add(Message.fromJson(i));
    }
    return result;
  } else {
    return null;
  }
}

Future<dynamic> sendMessage(Account account, String conv_id, String type, String content) async {
  http.Response response =
      await http.post(Uri.parse('$baseURL/m/$conv_id'), headers: {
    'id': account.id,
    'session': account.session,
  }, body: {
    'message': content
  });

  return response.statusCode == StatusCode.OK;

}
