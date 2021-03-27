import 'package:nosso/src/core/model/produto.dart';

class Medida {
  int id;
  String descricao;
  List<Produto> produtos = new List<Produto>();

  Medida({
    this.id,
    this.descricao,
    this.produtos,
  });

  Medida.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];

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
    data['descricao'] = this.descricao;

    if (this.produtos != null) {
      data['produtos'] = this.produtos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
