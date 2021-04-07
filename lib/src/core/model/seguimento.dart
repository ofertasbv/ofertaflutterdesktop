import 'package:nosso/src/core/model/categoria.dart';

class Seguimento {
  int id;
  String nome;
  List<Categoria> categorias;

  Seguimento({this.id, this.nome, this.categorias});

  Seguimento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    if (json['categorias'] != null) {
      categorias = new List<Categoria>();
      json['categorias'].forEach((v) {
        categorias.add(new Categoria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    if (this.categorias != null) {
      data['categorias'] = this.categorias.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
