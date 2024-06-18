import 'package:emprestimo/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InitialController extends GetxController {
  final box = GetStorage('emp');
  dynamic auth;

  @override
  void onInit() {
    auth = box.read('auth');
    super.onInit();
  }

  String verifyAuth() {
    if (auth != null) {
      return Routes.home;
    }
    return Routes.login;
  }
}
