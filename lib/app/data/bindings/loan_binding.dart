import 'package:emprestimo/app/data/controllers/loan_controller.dart';
import 'package:get/get.dart';

class LoanBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoanController>(() => LoanController());
  }
}
