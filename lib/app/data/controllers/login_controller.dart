import 'package:emprestimo/app/data/models/auth_model.dart';
import 'package:emprestimo/app/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final repository = Get.put(AuthRepository());
  RxBool showErrorSnackbar = false.obs;
  RxBool isLoggingIn = false.obs;
  dynamic mensagem;
  Auth? auth;

  final box = GetStorage('emp');

  void login() async {
    if (formKey.currentState!.validate()) {
      isLoggingIn.value = true;

      auth = await repository.getLogin(
          emailController.text, passwordController.text);

      if (auth != null) {
        // Salva os dados do usuário no armazenamento
        await box.write('auth', auth?.toJson());
        print('Token salvo: ${box.read('auth')}');
        Get.offAllNamed('/home');
      } else {
        showErrorSnackbar.value = true;
        showErrorMessage();
      }
    } else {
      showErrorSnackbar.value = true;
      showErrorMessage();
    }

    isLoggingIn.value = false;
  }

  void showErrorMessage() {
    if (showErrorSnackbar.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Erro de Autenticação',
          'Usuário ou senha inválidos',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        showErrorSnackbar.value = false;
      });
    }
  }
}
