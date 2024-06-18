import 'package:emprestimo/app/data/bindings/collaborator_binding.dart';
import 'package:emprestimo/app/data/bindings/initial_binding.dart';
import 'package:emprestimo/app/modules/collaborator/views/list_collaborator_view.dart';
import 'package:emprestimo/app/data/bindings/home_binding.dart';
import 'package:emprestimo/app/modules/home/views/home_view.dart';
import 'package:emprestimo/app/modules/initial/initial_view.dart';
import 'package:emprestimo/app/data/bindings/login_binding.dart';
import 'package:emprestimo/app/modules/login/views/login_view.dart';
import 'package:emprestimo/routes/app_pages.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.initial,
      page: () => const InitialView(),
      binding: InitialBinding(),
    ),
    // GetPage(
    //   name: Routes.loan,
    //   page: () => const LoanView(),
    //   binding: LoanBinding(),
    // ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.collaborator,
      page: () => const CollaboratorView(),
      binding: CollaboratorBinding(),
    ),
  ];
}
