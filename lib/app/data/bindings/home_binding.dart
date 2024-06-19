import 'package:emprestimo/app/data/controllers/home_controller.dart';
import 'package:emprestimo/app/data/repositories/loan_repository.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put(LoanRepository());
  }
}
