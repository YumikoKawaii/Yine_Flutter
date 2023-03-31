import 'package:http/http.dart' as http;
import 'package:yine/models/account.dart';

String baseURL = "http://54.251.180.228";

//Future<http.Response> requestChangeAvatar()

Future<http.Response> requestChangeProfile(String id, String session, String field, String value) async {

  return await http.put(
      Uri.parse('$baseURL/p'),
      headers: {
        'id': id,
        'session': session,
      },
      body: {
        'field': field,
        'value': value,
      }
  );

}

Future<http.Response> fetchProfileData(Account account, String target) async {
  
  return await http.get(
    Uri.parse('$baseURL/p/$target'),
    headers: {
      'id': account.id,
      'session': account.session,
    }
  );
  
}