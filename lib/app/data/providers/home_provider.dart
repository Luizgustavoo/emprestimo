import 'dart:convert';
import 'package:emprestimo/app/data/base_url.dart';
import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeApiClient {
  final http.Client httpClient = http.Client();

  getAllItens(String token) async {
    try {
      Uri itemUrl;
      String url = '$baseUrl/v1/itens';

      itemUrl = Uri.parse(url);

      var response = await httpClient.get(
        itemUrl,
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

  insertLoan(String token, int colaborador, String assinatura,
      List<Item> itens) async {
    try {
      var loanUrl = Uri.parse('$baseUrl/v1/emprestimo');

      var request = http.MultipartRequest('POST', loanUrl);

      request.fields.addAll({
        "colaborador_id": colaborador.toString(),
        "itens": json.encode(itens),
        "assinatura": assinatura
      });

      // if (assinatura.path.isNotEmpty) {
      //   request.files.add(await http.MultipartFile.fromPath(
      //     'assinatura',
      //     assinatura.path,
      //   ));
      // }

      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': token,
      });

      var response = await request.send();

      var responseStream = await response.stream.bytesToString();
      var httpResponse = http.Response(responseStream, response.statusCode);

      print(json.decode(httpResponse.body));

      if (response.statusCode == 200) {
        return json.decode(httpResponse.body);
      } else if (response.statusCode == 401 &&
          json.decode(httpResponse.body)['message'] == "Token has expired") {
        Get.defaultDialog(
          title: "Expirou",
          content: const Text(
              'O token de autenticação expirou, faça login novamente.'),
        );
        var box = GetStorage('credenciado');
        box.erase();
        Get.offAllNamed('/login');
      }
    } catch (err) {
      Exception(err);
    }
    return null;
  }
}
