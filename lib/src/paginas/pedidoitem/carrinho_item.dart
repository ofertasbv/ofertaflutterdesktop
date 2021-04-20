import 'package:flutter/material.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/core/model/produto.dart';

class CarrinhoItem extends ChangeNotifier {
  var itens = new List<PedidoItem>();

  double total = 0.0;

  int quantidade = 1;

  double valorUnitario;

  double valorTotal;

  double desconto;

  double totalDesconto;

  getItens() {
    return itens;
  }

  adicionar(PedidoItem item) {
    item.quantidade = quantidade;
    if (item.quantidade > 0) {
      item.valorUnitario = item.produto.estoque.valorUnitario;
      item.valorTotal = item.quantidade * item.valorUnitario;
      itens.add(item);
      itens.map((p) {
        print("Quantidade: ${p.quantidade}");
        print("***************************");
      });
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
      print("icrementando: ${item.quantidade}");
      calculateTotal();
    }
  }

  decremento(PedidoItem item) {
    if (item.quantidade > 1) {
      item.quantidade--;
      print("decrementando: ${item.quantidade}");
      calculateTotal();
    }
  }

  remove(PedidoItem item) {
    itens.remove(item);
    print("icrementando: ${item.produto.nome}");
    calculateTotal();
  }

  calculateTotal() {
    this.total = 0.0;
    itens.forEach((p) {
      p.valorTotal = p.quantidade * p.valorUnitario;
      total += p.valorTotal;
      print("quantidade: ${p.quantidade}");
      print("valorUnitário: ${p.valorUnitario}");
      print("valorTotal: ${p.valorTotal}");
      print("================================");
    });
    print("Calculando total ....");
    print("Total geral: ${total}");
    return total;
  }

  calculateDesconto() {
    this.totalDesconto = total - desconto;
    return totalDesconto;
  }
}
