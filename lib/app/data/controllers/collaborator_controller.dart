import 'package:emprestimo/app/data/models/collaborator_model.dart';
import 'package:emprestimo/app/data/repositories/collaborator_repository.dart';
import 'package:emprestimo/app/utils/user_service.dart';
import 'package:get/get.dart';

class CollaboratorController extends GetxController {
  RxList<Collaborator> listCollaborators = RxList<Collaborator>([]);
  RxBool isLoading = true.obs;

  RxInt? collaboratorSelected = 0.obs;

  final repository = Get.find<CollaboratorRepository>();

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
}
