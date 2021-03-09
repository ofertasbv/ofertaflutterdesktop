import 'package:nosso/src/core/model/categoria.dart';

class SubCategoria {
  int id;
  String nome;
  Categoria categoria;

  SubCategoria({
    this.id,
    this.nome,
    this.categoria,
  });


  SubCategoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    categoria = json['categoria'] != null
        ? new Categoria.fromJson(json['categoria'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    if (this.categoria != null) {
      data['categoria'] = this.categoria.toJson();
    }
    return data;
  }
}
