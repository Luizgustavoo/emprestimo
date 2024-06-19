import 'dart:convert';

import 'package:emprestimo/app/data/base_url.dart';
import 'package:emprestimo/app/data/models/loan_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoanApiClient {
  final http.Client httpClient = http.Client();
  getAllLoans(String token) async {
    try {
      Uri loanUrl;
      String url = '$baseUrl/v1/emprestimo';
      loanUrl = Uri.parse(url);
      var response = await httpClient.get(
        loanUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": token,
        },
      );
      print(json.decode(response.body));
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

  deleteItemLoan(String token, int itemId, Loan loan) async {
    try {
      Uri loanUrl;
      String url = '$baseUrl/v1/itensemprestimo/${loan.id}';
      loanUrl = Uri.parse(url);
      var response = await httpClient.put(loanUrl, headers: {
        "Accept": "application/json",
        "Authorization": token,
      }, body: {
        "item_id": itemId.toString(),
        "emprestimo_id": loan.id.toString(),
      });
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

  deleteLoan(String token, Loan loan) async {
    try {
      Uri loanUrl;
      String url = '$baseUrl/v1/emprestimo/devolver';
      loanUrl = Uri.parse(url);
      var response = await httpClient.post(loanUrl, headers: {
        "Accept": "application/json",
        "Authorization": token,
      }, body: {
        "emprestimo_id": loan.id.toString(),
      });
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
