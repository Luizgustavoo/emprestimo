import 'dart:convert';

import 'package:emprestimo/app/data/base_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CollaboratorApiClient {
  final http.Client httpClient = http.Client();

  getAllCollaborators(String token) async {
    try {
      Uri collaboratorUrl;
      String url = '$baseUrl/v1/colaborador';

      collaboratorUrl = Uri.parse(url);

      var response = await httpClient.get(
        collaboratorUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": token,
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401 &&
          json.decode(response.body)['message'] == "Token has expired") {
        Get.defaultDialog(
          title: "Expirou",
          content: const Text(
              'O token de autenticação expirou, faça login novamente.'),
        );
        var box = GetStorage('emp');
        box.erase();
        Get.offAllNamed('/login');
      }
    } catch (err) {
      //
    }
    return null;
  }
}
