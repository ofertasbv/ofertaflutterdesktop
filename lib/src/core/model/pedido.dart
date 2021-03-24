import 'package:nosso/src/core/model/cliente.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';

class Pedido {
  int id;
  String descricao;

  double valorFrete;
  double valorDesconto;
  double valorInicial;
  double valorTotal;
  List<PedidoItem> pedidoItems = new List();
  Cliente cliente;
  Loja loja;
  String statusPedido;
  DateTime dataHoraEntrega;
  DateTime dataRegistro;

  Pedido({
    this.id,
    this.descricao,
    this.valorFrete,
    this.valorDesconto,
    this.valorInicial,
    this.valorTotal,
    this.pedidoItems,
    this.cliente,
    this.loja,
    this.statusPedido,
    this.dataHoraEntrega,
    this.dataRegistro,
  });

  adicinarItem(List<PedidoItem> itens) {
    pedidoItems = itens;
    pedidoItems.forEach((p) {
      p.pedido;
    });
  }

  Pedido.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];

    valorFrete = json['valorFrete'];
    valorDesconto = json['valorDesconto'];
    valorInicial = json['valorInicial'];
    valorTotal = json['valorTotal'];

    if (json['pedidoItems'] != null) {
      pedidoItems = new List<PedidoItem>();
      json['pedidoItems'].forEach((v) {
        pedidoItems.add(new PedidoItem.fromJson(v));
      });
    }
    cliente =
        json['cliente'] != null ? new Cliente.fromJson(json['cliente']) : null;

    loja = json['loja'] != null ? new Loja.fromJson(json['loja']) : null;

    statusPedido = json['statusPedido'];

    dataHoraEntrega = DateTime.tryParse(json['dataHoraEntrega'].toString());
    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;

    data['valorFrete'] = this.valorFrete;
    data['valorDesconto'] = this.valorDesconto;
    data['valorInicial'] = this.valorInicial;
    data['valorTotal'] = this.valorTotal;

    if (this.pedidoItems != null) {
      data['pedidoItems'] = this.pedidoItems.map((v) => v.toJson()).toList();
    }
    if (this.cliente != null) {
      data['cliente'] = this.cliente.toJson();
    }
    if (this.loja != null) {
      data['loja'] = this.loja.toJson();
    }

    data['statusPedido'] = this.statusPedido;

    data['dataHoraEntrega'] = this.dataHoraEntrega.toIso8601String();
    data['dataRegistro'] = this.dataRegistro.toIso8601String();
    return data;
  }
}
