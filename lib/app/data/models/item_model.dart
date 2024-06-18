class Item {
  int? id;
  String? nome;
  String? marca;
  String? modelo;
  int? status;
  String? createdAt;
  String? updatedAt;

  Item(
      {this.id,
      this.nome,
      this.marca,
      this.modelo,
      this.status,
      this.createdAt,
      this.updatedAt});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    marca = json['marca'];
    modelo = json['modelo'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}
