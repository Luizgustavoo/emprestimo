import 'package:emprestimo/app/data/models/collaborator_model.dart';
import 'package:emprestimo/app/data/repositories/collaborator_repository.dart';
import 'package:emprestimo/app/utils/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CollaboratorController extends GetxController {
  RxList<Collaborator> listCollaborators = RxList<Collaborator>([]);
  RxBool isLoading = true.obs;

  RxInt? collaboratorSelected = 0.obs;

  final repository = Get.find<CollaboratorRepository>();

  final TextEditingController txtNomeController = TextEditingController();

  RxString txtTipoController = "".obs;
  RxList<String>? typeCollaborators =
      ['professor', 'administrativo', 'cozinha', 'limpeza', 'visitante'].obs;

  final GlobalKey<FormState> collaboratorKey = GlobalKey<FormState>();

  Map<String, dynamic> retorno = {"return": 1, "message": ""};
  dynamic mensagem;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getCollaborators() async {
    isLoading.value = true;
    try {
      final token = UserService.getToken();
      listCollaborators.value = await repository.getAll("Bearer $token");
    } catch (e) {
      //
    }
    isLoading.value = false;
  }

  clear() {
    txtNomeController.text = "";
    txtTipoController.value = "";
  }

  Future<Map<String, dynamic>> saveCollaborator() async {
    if (collaboratorKey.currentState!.validate()) {
      Collaborator collaborator = Collaborator(
          nome: txtNomeController.text, tipo: txtTipoController.value);

      final token = UserService.getToken();

      retorno =
          await repository.insertCollaborators("Bearer $token", collaborator);
    }

    clear();
    getCollaborators();

    return retorno;
  }

  Future<Map<String, dynamic>> updateCollaborator(int id) async {
    if (collaboratorKey.currentState!.validate()) {
      Collaborator collaborator = Collaborator(
        id: id,
        nome: txtNomeController.text,
        tipo: txtTipoController.value,
      );

      final token = UserService.getToken();

      retorno =
          await repository.updateCollaborators("Bearer $token", collaborator);
    }

    clear();
    getCollaborators();

    return retorno;
  }

  Future<Map<String, dynamic>> deleteCollaborator(
      Collaborator collaborator) async {
    final token = UserService.getToken();

    retorno =
        await repository.deleteCollaborators("Bearer $token", collaborator);

    clear();
    getCollaborators();

    return retorno;
  }

  fillInFieldsItem(Collaborator collaborator) {
    txtNomeController.text = collaborator.nome!;
    txtTipoController.value = collaborator.tipo!;
  }
}
