import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/promocaotipo.dart';

class Promocao {
  int id;
  String nome;
  String descricao;
  String foto;
  double desconto;
  DateTime dataRegistro;
  DateTime dataInicio;
  DateTime dataFinal;
  Loja loja;
  PromocaoTipo promocaoTipo;
  bool status;
  List<Produto> produtos = new List<Produto>();

  Promocao({
    this.id,
    this.nome,
    this.descricao,
    this.foto,
    this.desconto,
    this.dataRegistro,
    this.dataInicio,
    this.dataFinal,
    this.loja,
    this.promocaoTipo,
    this.status,
    this.produtos,
  });

  Promocao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    foto = json['foto'];
    desconto = json['desconto'];
    status = json['status'];

    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
    dataInicio = DateTime.tryParse(json['dataInicio'].toString());
    dataFinal = DateTime.tryParse(json['dataFinal'].toString());

    loja = json['loja'] != null ? new Loja.fromJson(json['loja']) : null;
    promocaoTipo = json['promocaoTipo'] != null
        ? new PromocaoTipo.fromJson(json['promocaoTipo'])
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
    data['descricao'] = this.descricao;
    data['foto'] = this.foto;
    data['desconto'] = this.desconto;
    data['status'] = this.status;

    data['dataRegistro'] = this.dataRegistro.toIso8601String();
    data['dataInicio'] = this.dataInicio.toIso8601String();
    data['dataFinal'] = this.dataFinal.toIso8601String();

    if (this.loja != null) {
      data['loja'] = this.loja.toJson();
    }

    if (this.promocaoTipo != null) {
      data['promocaoTipo'] = this.promocaoTipo.toJson();
    }

    if (this.produtos != null) {
      data['produtos'] = this.produtos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
