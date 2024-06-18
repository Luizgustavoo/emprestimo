import 'dart:convert';
import 'dart:typed_data';

import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:emprestimo/app/data/repositories/home_repository.dart';
import 'package:emprestimo/app/utils/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class HomeController extends GetxController {
  final TextEditingController dateController = TextEditingController();

  RxList<Item> listItems = RxList<Item>([]);
  RxList<Item> cartItems = RxList<Item>([]);

  RxBool isLoading = true.obs;

  final repository = Get.find<HomeRepository>();

  Map<String, dynamic> retorno = {"return": 1, "message": ""};
  dynamic mensagem;

  var photoUrlPath = ''.obs;

  void addToCart(Item item) {
    cartItems.add(item);
    listItems.remove(item);
  }

  void removeToCart(Item item) {
    listItems.add(item);
    cartItems.remove(item);
  }

  int get cartCount => cartItems.length;

  @override
  void onInit() {
    getItens();
    super.onInit();
  }

  Future<void> getItens() async {
    isLoading.value = true;
    try {
      final token = UserService.getToken();
      listItems.value = await repository.getAll("Bearer $token");
    } catch (e) {
      //
    }
    isLoading.value = false;
  }

  insertLoan(int collaborator, SignatureController signature) async {
    // if (peopleFormKey.currentState!.validate()) {

    // final collaboratorController = Get.put(CollaboratorController());

    final Uint8List? data = await signature.toPngBytes();
    String? base64Image;
    if (data != null) {
      base64Image = base64Encode(data);
      return base64Image;
    }

    final token = UserService.getToken();

    mensagem = await repository.insertLoan(
        "Bearer $token", collaborator, base64Image!, cartItems);

    if (mensagem != null) {
      if (mensagem['message'] == 'success') {
        retorno = {"return": 0, "message": "Operação realizada com sucesso!"};
      }
    } else if (mensagem['message'] == 'ja_existe') {
      retorno = {
        "return": 1,
        "message": "Já existe um usuário com esse e-mail!"
      };
    }
    // } else {
    //   retorno = {
    //     "return": 1,
    //     "message": "Preencha todos os campos da família!"
    //   };
    // }
    return retorno;
  }
}
