import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:emprestimo/app/data/models/user_model.dart';

class ItensEmprestimo {
  int? id;
  int? emprestimoId;
  int? itemId;
  int? situacaoId;
  dynamic dataDevolucao;
  String? createdAt;
  String? updatedAt;
  Item? itens;
  User? usuariorecebeu;

  ItensEmprestimo(
      {this.id,
      this.emprestimoId,
      this.itemId,
      this.situacaoId,
      this.dataDevolucao,
      this.createdAt,
      this.itens,
      this.usuariorecebeu,
      this.updatedAt});

  ItensEmprestimo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emprestimoId = json['emprestimo_id'];
    itemId = json['item_id'];
    situacaoId = json['situacao_id'];
    dataDevolucao = json['data_devolucao'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itens = json['itens'] != null ? Item.fromJson(json['itens']) : null;
    usuariorecebeu = json['usuariorecebeu'] != null
        ? User.fromJson(json['usuariorecebeu'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emprestimo_id'] = emprestimoId;
    data['item_id'] = itemId;
    data['situacao_id'] = situacaoId;
    data['data_devolucao'] = dataDevolucao;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['usuario_recebeu_devolucao'] = usuariorecebeu;
    if (itens != null) {
      data['itens'] = itens!.toJson();
    }
    data['usuariorecebeu'] = usuariorecebeu;
    return data;
  }
}
