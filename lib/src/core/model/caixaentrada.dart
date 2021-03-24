import 'package:nosso/src/core/model/caixa.dart';
import 'package:nosso/src/core/model/pedido.dart';

class CaixaFluxoEntrada {
  int id;
  String descricao;
  double valorEntrada;
  DateTime dataRegistro;
  Caixa caixa;
  Pedido pedido;

  CaixaFluxoEntrada({
    this.id,
    this.descricao,
    this.valorEntrada,
    this.dataRegistro,
    this.caixa,
    this.pedido,
  });

  CaixaFluxoEntrada.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valorEntrada = json['valorEntrada'];
    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());

    caixa = json['caixa'] != null ? new Caixa.fromJson(json['caixa']) : null;

    pedido =
        json['pedido'] != null ? new Pedido.fromJson(json['pedido']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['valorEntrada'] = this.valorEntrada;
    data['dataRegistro'] = this.dataRegistro.toIso8601String();

    if (this.caixa != null) {
      data['caixa'] = this.caixa.toJson();
    }

    if (this.pedido != null) {
      data['pedido'] = this.pedido.toJson();
    }
    return data;
  }
}
