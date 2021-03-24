import 'package:nosso/src/core/model/fatura.dart';
import 'package:nosso/src/core/model/pedido.dart';

class Pagamento {
  int id;
  int quantidade;
  double valor;
  DateTime dataPagamento;
  String pagamentoForma;
  String pagamentoTipo;
  List<Fatura> faturas;
  Pedido pedido;

  Pagamento({
    this.id,
    this.quantidade,
    this.valor,
    this.dataPagamento,
    this.pagamentoForma,
    this.pagamentoTipo,
    this.faturas,
    this.pedido,
  });

  Pagamento.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantidade = json['quantidade'];
    valor = json['valor'];
    dataPagamento = DateTime.tryParse(json['dataPagamento'].toString());
    pagamentoForma = json['pagamentoForma'];
    pagamentoTipo = json['pagamentoTipo'];

    if (json['faturas'] != null) {
      faturas = new List<Fatura>();
      json['faturas'].forEach((v) {
        faturas.add(new Fatura.fromJson(v));
      });
    }

    pedido =
        json['pedido'] != null ? new Pedido.fromJson(json['pedido']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantidade'] = this.quantidade;
    data['valor'] = this.valor;
    data['dataPagamento'] = this.dataPagamento.toIso8601String();
    data['pagamentoForma'] = this.pagamentoForma;
    data['pagamentoTipo'] = this.pagamentoTipo;

    if (this.faturas != null) {
      data['faturas'] = this.faturas.map((v) => v.toJson()).toList();
    }

    if (this.pedido != null) {
      data['pedido'] = this.pedido.toJson();
    }

    return data;
  }
}
