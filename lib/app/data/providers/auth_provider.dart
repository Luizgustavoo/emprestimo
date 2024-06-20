import 'dart:convert';

import 'package:emprestimo/app/data/base_url.dart';
import 'package:http/http.dart' as http;

class AuthApiClient {
  final http.Client httpClient = http.Client();

  getLogin(String email, String password) async {
    var loginUrl = Uri.parse('$baseUrl/login');
    try {
      var response = await httpClient
          .post(loginUrl, body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        print('Erro de autenticação: Usuário ou senha inválidos');
      } else {
        print('Erro - get:${response.body}');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
