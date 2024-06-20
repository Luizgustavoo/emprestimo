import 'dart:convert';

import 'package:emprestimo/app/data/base_url.dart';
import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:emprestimo/app/utils/custom_services.dart';
import 'package:emprestimo/app/utils/user_service.dart';
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

  insertLoan(String token, int colaborador, String assinatura, List<Item> itens,
      String date) async {
    try {
      var loanUrl = Uri.parse('$baseUrl/v1/emprestimo');

      var request = http.MultipartRequest('POST', loanUrl);

      String data_emprestimo = CustomServices.dateTimePtBr(date.toString());

      request.fields.addAll({
        "colaborador_id": colaborador.toString(),
        "itens": json.encode(itens),
        "assinatura": assinatura,
        "usuario_id": UserService.getUserId().toString(),
        "data_emprestimo": data_emprestimo.toString()
      });

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

  insertItem(String token, Item item) async {
    try {
      var itemUrl = Uri.parse('$baseUrl/v1/itens');

      var request = {
        "nome": item.nome.toString(),
        "marca": item.marca.toString(),
        "modelo": item.modelo.toString(),
        'status': '1'
      };

      var response = await httpClient.post(
        itemUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": token,
        },
        body: request,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401 &&
          json.decode(response.body)['message'] == "Token has expired") {
        var box = GetStorage('credenciado');
        box.erase();
        Get.offAllNamed('/login');
      }
    } catch (err) {
      Exception(err);
    }
    return null;
  }

  updateItem(String token, Item item) async {
    try {
      var itemUrl = Uri.parse('$baseUrl/v1/itens/${item.id}');

      var request = {
        "nome": item.nome.toString(),
        "marca": item.marca.toString(),
        "modelo": item.modelo.toString(),
        'status': '1'
      };

      var response = await httpClient.put(
        itemUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": token,
        },
        body: request,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401 &&
          json.decode(response.body)['message'] == "Token has expired") {
        var box = GetStorage('credenciado');
        box.erase();
        Get.offAllNamed('/login');
      }
    } catch (err) {
      Exception(err);
    }
    return null;
  }

  deleteItem(String token, Item item) async {
    try {
      var itemUrl = Uri.parse('$baseUrl/v1/itens/${item.id}');

      var response = await httpClient.delete(
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
