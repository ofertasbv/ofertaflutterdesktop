import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/produto.dart';

class SubCategoria {
  int id;
  String nome;
  Categoria categoria;
  List<Produto> produtos = new List<Produto>();

  SubCategoria({
    this.id,
    this.nome,
    this.categoria,
    this.produtos,
  });

  SubCategoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    categoria = json['categoria'] != null
        ? new Categoria.fromJson(json['categoria'])
        : null;

    if (json['produtos'] != null) {
      produtos = new List<Produto>();
      json['produtos'].forEach((v) {
        produtos.add(new Produto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    if (this.categoria != null) {
      data['categoria'] = this.categoria.toJson();
    }
    if (this.produtos != null) {
      data['produtos'] = this.produtos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
