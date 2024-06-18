import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:emprestimo/app/data/providers/home_provider.dart';

class HomeRepository {
  final HomeApiClient apiClient = HomeApiClient();

  getAll(String token) async {
    List<Item> list = <Item>[];

    var response = await apiClient.getAllItens(token);

    if (response != null) {
      response['data'].forEach((e) {
        list.add(Item.fromJson(e));
      });
    }

    return list;
  }

  insertLoan(String token, int colaborador, String assinatura,
      List<Item>? items) async {
    try {
      var response =
          await apiClient.insertLoan(token, colaborador, assinatura, items!);

      return response;
    } catch (e) {
      Exception(e);
    }
  }
}
