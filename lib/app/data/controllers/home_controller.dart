import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:emprestimo/app/data/repositories/home_repository.dart';
import 'package:emprestimo/app/utils/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController dateController = TextEditingController();

  RxList<Item> listItems = RxList<Item>([]);
  RxList<Item> cartItems = RxList<Item>([]);
  final GlobalKey<FormState> loanKey = GlobalKey<FormState>();

  RxBool isLoading = true.obs;

  final repository = Get.find<HomeRepository>();

  Map<String, dynamic> retorno = {"return": 1, "message": ""};
  dynamic mensagem;

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

  Future<Map<String, dynamic>> insertLoan(
      int collaborator, String signature) async {
    final token = UserService.getToken();

    if (loanKey.currentState!.validate()) {
      mensagem = await repository.insertLoan(
          "Bearer $token", collaborator, signature, cartItems);
      if (mensagem != null) {
        if (mensagem['message'] == 'success') {
          retorno = {"return": 0, "message": "Operação realizada com sucesso!"};
          getItens();
        }
      } else if (mensagem['message'] == 'ja_existe') {
        retorno = {
          "return": 1,
          "message": "Já existe um usuário com esse e-mail!"
        };
      }
    }
    return retorno;
  }
}
