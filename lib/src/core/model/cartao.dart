import 'package:nosso/src/core/enum/cartao_emissor.dart';
import 'package:nosso/src/core/enum/cartao_tipo.dart';

class Cartao {
  int id;
  String nome;
  String numeroCartao;
  String numeroSeguranca;
  DateTime dataValidade;
  CartaoEmissor cartaoEmissor;
  CartaoTipo cartaoTipo;

  Cartao({
    this.id,
    this.nome,
    this.numeroCartao,
    this.numeroSeguranca,
    this.dataValidade,
    this.cartaoEmissor,
    this.cartaoTipo,
  });

  Cartao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    numeroCartao = json['numeroCartao'];
    numeroSeguranca = json['numeroSeguranca'];
    dataValidade = DateTime.tryParse(json['dataValidade'].toString());
    cartaoEmissor = json['cartaoEmissor'];
    cartaoTipo = json['cartaoTipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['numeroCartao'] = this.numeroCartao;
    data['numeroSeguranca'] = this.numeroSeguranca;
    data['dataValidade'] = this.dataValidade.toIso8601String();
    data['cartaoEmissor'] = this.cartaoEmissor;
    data['cartaoTipo'] = this.cartaoTipo;
    return data;
  }
}
