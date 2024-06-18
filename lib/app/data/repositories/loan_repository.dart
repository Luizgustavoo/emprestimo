import 'package:emprestimo/app/data/models/loan_model.dart';
import 'package:emprestimo/app/data/providers/loan_provider.dart';

class LoanRepository {
  final LoanApiClient apiClient = LoanApiClient();
  getAllLoans(String token) async {
    List<Loan> list = <Loan>[];

    var response = await apiClient.getAllLoans(token);

    if (response != null) {
      response['data']['data'].forEach((e) {
        list.add(Loan.fromJson(e));
      });
    }

    return list;
  }

  deleteItemLoan(String token, Loan loan) async {
    try {
      var response = await apiClient.deleteItemLoan(token, loan);

      return response;
    } catch (e) {
      print(e);
    }
  }
}
