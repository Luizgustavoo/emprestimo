import 'package:emprestimo/app/data/models/collaborator_model.dart';
import 'package:emprestimo/app/data/models/item_model.dart';
import 'package:emprestimo/app/data/models/user_model.dart';

class Loan {
  int? id;
  int? colaboradorId;
  String? assinatura;
  String? createdAt;
  String? updatedAt;
  Collaborator? colaborador;
  User? user;
  List<Item>? itens;

  Loan(
      {this.id,
      this.colaboradorId,
      this.assinatura,
      this.createdAt,
      this.updatedAt,
      this.colaborador,
      this.user,
      this.itens});

  Loan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    colaboradorId = json['colaborador_id'];
    assinatura = json['assinatura'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    colaborador = json['colaborador'] != null
        ? Collaborator.fromJson(json['colaborador'])
        : null;
    user = json['usuario'] != null ? User.fromJson(json['usuario']) : null;
    if (json['itens'] != null) {
      itens = <Item>[];
      json['itens'].forEach((v) {
        itens!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['colaborador_id'] = colaboradorId;
    data['assinatura'] = assinatura;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (colaborador != null) {
      data['colaborador'] = colaborador!.toJson();
    }
    if (user != null) {
      data['usuario'] = user!.toJson();
    }
    if (itens != null) {
      data['itens'] = itens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
