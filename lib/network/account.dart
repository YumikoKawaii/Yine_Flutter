import 'package:http/http.dart' as http;

String baseURL = "http://10.0.2.2:9010";

Future<http.Response> requestLogin(String email, String password) async {

  return await http.get(
    Uri.parse('$baseURL/a?email=$email&password=$password'),
  );

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
