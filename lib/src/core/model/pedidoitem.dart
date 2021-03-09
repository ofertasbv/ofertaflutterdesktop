import 'package:nosso/src/core/model/produto.dart';

class PedidoItem {
  int id;
  double valorUnitario;
  int quantidade;
  DateTime dataRegistro;
  Produto produto;
  double valorTotal;

  PedidoItem({
    this.id,
    this.valorUnitario,
    this.quantidade,
    this.dataRegistro,
    this.produto,
    this.valorTotal,
  });

  PedidoItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    valorUnitario = json['valorUnitario'];
    quantidade = json['quantidade'];
    dataRegistro = DateTime.tryParse(json['dataRegistro'].toString());
    produto =
        json['produto'] != null ? new Produto.fromJson(json['produto']) : null;
    valorTotal = json['valorTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['valorUnitario'] = this.valorUnitario;
    data['quantidade'] = this.quantidade;
    data['dataRegistro'] = this.dataRegistro.toIso8601String();
    if (this.produto != null) {
      data['produto'] = this.produto.toJson();
    }
    data['valorTotal'] = this.valorTotal;
    return data;
  }
}
