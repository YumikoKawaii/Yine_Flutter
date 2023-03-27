import 'package:http/http.dart' as http;

String baseURL = "http://54.251.180.228";

//Future<http.Response> requestChangeAvatar()

Future<http.Response> requestChangeProfile(String field, String value) async {

  return await http.post(
      Uri.parse('$baseURL/p'),
      body: {
        'field': field,
        'value': value,
      }
  );

}