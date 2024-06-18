import 'package:emprestimo/app/data/controllers/collaborator_controller.dart';
import 'package:get/get.dart';

class CollaboratorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollaboratorController>(() => CollaboratorController());
  }
}
