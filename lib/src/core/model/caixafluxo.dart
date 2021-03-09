import 'package:nosso/src/core/model/caixa.dart';
import 'package:nosso/src/core/model/vendedor.dart';

class CaixaFluxo {
  int id;
  String descricao;
  double saldoAnterior;
  double valorEntrada;
  double valorSaida;
  double valorTotal;
  DateTime dataRegistro;
  String caixaStatus;
  bool status;
  Caixa caixa;
  Vendedor vendedor;

  CaixaFluxo({
    this.id,
    this.descricao,
    this.saldoAnterior,
    this.valorEntrada,
    this.valorSaida,
    this.valorTotal,
    this.dataRegistro,
    this.caixaStatus,
    this.status,
    this.caixa,
    this.vendedor,
  });

  CaixaFluxo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    saldoAnterior = json['saldoAnterior'];
    valorEntrada = json['valorEntrada'];
    valorSaida = json['valorSaida'];
    valorTotal = json['valorTotal'];
    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
    caixaStatus = json['caixaStatus'];
    status = json['status'];

    caixa = json['caixa'] != null ? new Caixa.fromJson(json['caixa']) : null;

    vendedor = json['vendedor'] != null
        ? new Vendedor.fromJson(json['vendedor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['saldoAnterior'] = this.saldoAnterior;
    data['valorEntrada'] = this.valorEntrada;
    data['valorSaida'] = this.valorSaida;
    data['dataRegistro'] = this.dataRegistro.toIso8601String();
    data['caixaStatus'] = this.caixaStatus;
    data['status'] = this.status;

    if (this.caixa != null) {
      data['caixa'] = this.caixa.toJson();
    }

    if (this.vendedor != null) {
      data['vendedor'] = this.vendedor.toJson();
    }
    return data;
  }
}
