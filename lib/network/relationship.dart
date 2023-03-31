import 'package:http/http.dart' as http;
import 'package:yine/models/account.dart';

String baseURL = "http://54.251.180.228";

Future<http.Response> fetchRelationships(Account account) async {

  return await http.get(
    Uri.parse('$baseURL/rlts'),
    headers: {
      'id': account.id,
      'session': account.session,
    }
  );

}