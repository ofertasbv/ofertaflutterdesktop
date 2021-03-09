import 'package:nosso/src/core/model/loja.dart';
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
  });

  Promocao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    foto = json['foto'];
    desconto = json['desconto'];

    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
    dataInicio = DateTime.tryParse(json['dataInicio'].toString());
    dataFinal = DateTime.tryParse(json['dataFinal'].toString());

    loja = json['loja'] != null ? new Loja.fromJson(json['loja']) : null;
    promocaoTipo = json['promocaoTipo'] != null
        ? new PromocaoTipo.fromJson(json['promocaoTipo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['foto'] = this.foto;
    data['desconto'] = this.desconto;

    data['dataRegistro'] = this.dataRegistro.toIso8601String();
    data['dataInicio'] = this.dataInicio.toIso8601String();
    data['dataFinal'] = this.dataFinal.toIso8601String();

    if (this.loja != null) {
      data['loja'] = this.loja.toJson();
    }

    if (this.promocaoTipo != null) {
      data['promocaoTipo'] = this.promocaoTipo.toJson();
    }
    return data;
  }
}
