import 'package:http/http.dart' as http;

String baseURL = "http://54.251.180.228";

Future<http.Response> requestLogin(String email, String password) async {

  var response = await http.get(
    Uri.parse('$baseURL/a?email=$email&password=$password'),
  );

  print(response.statusCode);
  return response;
}

Future<http.Response> requestRegister(String email, String password) async {
  
  return await http.post(
    Uri.parse('$baseURL/a'),
    body: {
      'email': email,
      'password': password,
    }
  );

}
