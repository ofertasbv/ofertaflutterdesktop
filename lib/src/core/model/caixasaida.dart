import 'package:nosso/src/core/model/caixa.dart';

class CaixaFluxoSaida {
  int id;
  String descricao;
  double valorSaida;
  DateTime dataRegistro;
  Caixa caixa;

  CaixaFluxoSaida({
    this.id,
    this.descricao,
    this.valorSaida,
    this.dataRegistro,
    this.caixa,
  });

  CaixaFluxoSaida.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valorSaida = json['valorSaida'];
    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
    caixa = json['caixa'] != null ? new Caixa.fromJson(json['caixa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['valorSaida'] = this.valorSaida;
    data['dataRegistro'] = this.dataRegistro.toIso8601String();
    if (this.caixa != null) {
      data['caixa'] = this.caixa.toJson();
    }
    return data;
  }
}
