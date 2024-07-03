import 'package:emprestimo/app/data/models/user_model.dart';

class ItemLoan {
  int? id;
  int? emprestimoId;
  int? itemId;
  int? situacaoId;
  dynamic dataDevolucao;
  String? createdAt;
  String? updatedAt;
  User? usuarioRecebeu;

  ItemLoan(
      {this.id,
      this.emprestimoId,
      this.itemId,
      this.situacaoId,
      this.dataDevolucao,
      this.createdAt,
      this.updatedAt});

  ItemLoan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emprestimoId = json['emprestimo_id'];
    itemId = json['item_id'];
    situacaoId = json['situacao_id'];
    dataDevolucao = json['data_devolucao'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    usuarioRecebeu = json['usuariorecebeu'] != null
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
    if (usuarioRecebeu != null) {
      data['usuariorecebeu'] = usuarioRecebeu!.toJson();
    }
    data['updated_at'] = updatedAt;
    return data;
  }
}
