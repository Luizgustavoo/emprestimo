import 'package:emprestimo/app/data/models/loan_model.dart';
import 'package:emprestimo/app/data/repositories/loan_repository.dart';
import 'package:emprestimo/app/utils/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LoanController extends GetxController {
  RxList<Loan> listLoan = RxList<Loan>([]);
  RxBool isLoading = true.obs;
  TextEditingController searchController = TextEditingController();

  final repository = Get.find<LoanRepository>();

  dynamic mensagem;

  @override
  void onInit() {
    getLoans();
    super.onInit();
  }

  void initializeTimeZones() {
    tz.initializeTimeZones();
  }

  String formatApiDate(String apiDate) {
    initializeTimeZones();

    final location = tz.getLocation('America/Sao_Paulo');

    DateTime date = DateTime.parse(apiDate);

    final tz.TZDateTime localDate = tz.TZDateTime.from(date, location);

    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm\'h\'');
    return formatter.format(localDate);
  }

  Future<void> getLoans() async {
    isLoading.value = true;
    try {
      final token = UserService.getToken();
      listLoan.value = await repository.getAllLoans("Bearer $token");
    } catch (e) {
      Exception(e);
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

  void filterLoans() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      listLoan.assignAll(listLoan);
    } else {
      listLoan.assignAll(listLoan.where((loan) {
        bool containsColaborador =
            loan.colaborador?.nome?.toLowerCase().contains(query) ?? false;
        bool containsUser =
            loan.user?.name?.toLowerCase().contains(query) ?? false;
        bool containsDate =
            loan.createdAt?.toLowerCase().contains(query) ?? false;
        bool containsItem = loan.itens?.any(
                (item) => item.itens!.nome!.toLowerCase().contains(query)) ??
            false;
        return containsColaborador ||
            containsUser ||
            containsDate ||
            containsItem;
      }).toList());
    }
  }
}
