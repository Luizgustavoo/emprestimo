class Collaborator {
  int? id;
  String? nome;
  String? tipo;
  int? status;
  String? createdAt;
  String? updatedAt;

  Collaborator(
      {this.id,
      this.nome,
      this.tipo,
      this.status,
      this.createdAt,
      this.updatedAt});

  Collaborator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    tipo = json['tipo'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['tipo'] = tipo;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
