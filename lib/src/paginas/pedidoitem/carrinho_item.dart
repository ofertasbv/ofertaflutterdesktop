import 'package:flutter/material.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/core/model/produto.dart';

class CarrinhoItem extends ChangeNotifier {
  var itens = new List<PedidoItem>();
  double total = 0;

  int quantidade = 1;

  double valorUnitario = 0;

  double valorTotal = 0;

  double desconto = 0;

  double totalDesconto = 0;

  getItens() {
    return itens;
  }

  adicionar(PedidoItem item) {
    item.quantidade = quantidade;
    print("Qunatidade: ${item.quantidade}");
    if (item.quantidade > 0) {
      item.valorUnitario = item.produto.estoque.valorUnitario;
      item.valorTotal = item.quantidade * item.valorUnitario;
      itens.add(item);
      calculateTotal();
    }
  }

  isExiste(Produto p) {
    var result = false;
    for (PedidoItem p in itens) {
      if (p.produto.id == p.id) {
        return result = true;
      }
    }
    return result;
  }

  isExisteItem(PedidoItem item) {
    var result = false;
    for (PedidoItem p in itens) {
      if (item.produto.nome == p.produto.nome) {
        return result = true;
      }
    }
    return result;
  }

  incremento(PedidoItem item) {
    if (item.quantidade < 10) {
      item.quantidade++;
      calculateTotal();
    }
  }

  decremento(PedidoItem item) {
    if (item.quantidade > 1) {
      item.quantidade--;
      calculateTotal();
    }
  }

  remove(PedidoItem item) {
    itens.remove(item);
    calculateTotal();
  }

  calculateTotal() {
    this.total = 0.0;
    itens.forEach((p) {
      total += p.valorTotal;
    });
    notifyListeners();
    return total;
  }

  calculateDesconto() {
    this.totalDesconto = total - desconto;
    return totalDesconto;
  }
}
