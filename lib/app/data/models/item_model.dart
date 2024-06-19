import 'package:emprestimo/app/data/models/itens_emprestimo_model.dart';

class Item {
  int? id;
  String? nome;
  String? marca;
  String? modelo;
  int? status;
  String? createdAt;
  String? updatedAt;

  ItensEmprestimo? itensEmprestimo;

  Item({
    this.id,
    this.nome,
    this.marca,
    this.modelo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.itensEmprestimo,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    marca = json['marca'];
    modelo = json['modelo'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    itensEmprestimo =
        json['pivot'] != null ? ItensEmprestimo.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['marca'] = marca;
    data['modelo'] = modelo;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (itensEmprestimo != null) {
      data['pivot'] = itensEmprestimo!.toJson();
    }
    return data;
  }
}
