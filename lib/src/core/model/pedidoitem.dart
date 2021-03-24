import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/tamanho.dart';

class PedidoItem {
  int id;
  double valorUnitario;
  int quantidade;
  Produto produto;
  double valorTotal;
  Pedido pedido;
  Tamanho tamanho;

  PedidoItem({
    this.id,
    this.valorUnitario,
    this.quantidade,
    this.produto,
    this.valorTotal,
    this.pedido,
    this.tamanho,
  });

  PedidoItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valorUnitario = json['valorUnitario'];
    quantidade = json['quantidade'];
    produto =
        json['produto'] != null ? new Produto.fromJson(json['produto']) : null;
    valorTotal = json['valorTotal'];

    pedido =
        json['pedido'] != null ? new Pedido.fromJson(json['pedido']) : null;

    tamanho =
        json['tamanho'] != null ? new Tamanho.fromJson(json['tamanho']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['valorUnitario'] = this.valorUnitario;
    data['quantidade'] = this.quantidade;
    if (this.produto != null) {
      data['produto'] = this.produto.toJson();
    }
    data['valorTotal'] = this.valorTotal;

    if (this.pedido != null) {
      data['pedido'] = this.pedido.toJson();
    }

    if (this.tamanho != null) {
      data['tamanho'] = this.tamanho.toJson();
    }

    return data;
  }
}
