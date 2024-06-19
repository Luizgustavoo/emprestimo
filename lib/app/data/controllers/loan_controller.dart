import 'package:emprestimo/app/data/models/loan_model.dart';
import 'package:emprestimo/app/data/repositories/loan_repository.dart';
import 'package:emprestimo/app/utils/user_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LoanController extends GetxController {
  RxList<Loan> listLoan = RxList<Loan>([]);
  RxBool isLoading = true.obs;

  final repository = Get.find<LoanRepository>();

  dynamic mensagem;

  @override
  void onInit() {
    getLoans();
    super.onInit();
  }

  String formatApiDate(String apiDate) {
    DateTime date = DateTime.parse(apiDate);

    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm\'h\'');
    return formatter.format(date);
  }

  Future<void> getLoans() async {
    isLoading.value = true;
    try {
      final token = UserService.getToken();
      listLoan.value = await repository.getAllLoans("Bearer $token");
    } catch (e) {
      //
    }
    isLoading.value = false;
  }

  deleteItemLoan(int itemId, int loanId) async {
    Loan loan = Loan(
      id: loanId,
    );
    final token = UserService.getToken();
    mensagem = await repository.deleteItemLoan("Bearer $token", itemId, loan);

    getLoans();

    return mensagem;
  }

  deleteLoan(int loanId) async {
    Loan loan = Loan(
      id: loanId,
    );
    final token = UserService.getToken();
    mensagem = await repository.deleteLoan("Bearer $token", loan);

    getLoans();

    return mensagem;
  }
}
