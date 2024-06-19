class ItensEmprestimo {
  int? id;
  int? emprestimo_id;
  int? item_id;
  int? situacao_id;
  dynamic? data_devolucao;
  String? createdAt;
  String? updatedAt;

  ItensEmprestimo(
      {this.id,
      this.emprestimo_id,
      this.item_id,
      this.situacao_id,
      this.data_devolucao,
      this.createdAt,
      this.updatedAt});

  ItensEmprestimo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emprestimo_id = json['emprestimo_id'];
    item_id = json['item_id'];
    situacao_id = json['situacao_id'];
    data_devolucao = json['data_devolucao'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['emprestimo_id'] = emprestimo_id;
    data['item_id'] = item_id;
    data['situacao_id'] = situacao_id;
    data['data_devolucao'] = data_devolucao;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
