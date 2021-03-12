import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/paginas/pedido/pedido_create_page.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PedidoTable extends StatefulWidget {
  @override
  _PedidoTableState createState() => _PedidoTableState();
}

class _PedidoTableState extends State<PedidoTable>
    with AutomaticKeepAliveClientMixin<PedidoTable> {
  var pedidoController = GetIt.I.get<PedidoController>();
  var produtoController = GetIt.I.get<ProdutoController>();

  @override
  void initState() {
    pedidoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return pedidoController.getAll();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return builderConteudoList();
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Pedido> pedidos = pedidoController.pedidos;
          if (pedidoController.error != null) {
            return Text("Não foi possível buscar permissões");
          }

          if (pedidos == null) {
            return Center(
              child: CircularProgressor(),
            );
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderTable(pedidos),
          );
        },
      ),
    );
  }

  builderTable(List<Pedido> pedidos) {
    return DataTable(
      sortAscending: true,
      showCheckboxColumn: true,
      showBottomBorder: true,
      columnSpacing: 50,
      columns: [
        DataColumn(label: Text("Código")),
        DataColumn(label: Text("Descrição.")),
        DataColumn(label: Text("Valor")),
        DataColumn(label: Text("Total")),
        DataColumn(label: Text("Desconto.")),
        DataColumn(label: Text("Cliente")),
        DataColumn(label: Text("Loja")),
        DataColumn(label: Text("Status")),
        DataColumn(label: Text("Visualizar")),
        DataColumn(label: Text("Editar")),
      ],
      rows: pedidos
          .map(
            (p) => DataRow(
              onSelectChanged: (i) {
                setState(() {
                  // selecionaItem(p);
                });
              },
              cells: [
                DataCell(Text("${p.id}")),
                DataCell(Text("${p.descricao}")),
                DataCell(Text(
                  "${p.valorInicial}",
                  style: TextStyle(color: Colors.red),
                )),
                DataCell(Text(
                  "${p.valorTotal}",
                  style: TextStyle(color: Colors.red),
                )),
                DataCell(Text(
                  "${p.valorDesconto}",
                  style: TextStyle(color: Colors.red),
                )),
                DataCell(Text("${p.cliente.nome}")),
                DataCell(Text("${p.loja.nome}")),
                DataCell(Text("${p.statusPedido}")),
                DataCell(IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return PedidoCreatePage(
                            pedido: p,
                          );
                        },
                      ),
                    );
                  },
                )),
                DataCell(IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return PedidoCreatePage(
                            pedido: p,
                          );
                        },
                      ),
                    );
                  },
                )),
              ],
            ),
          )
          .toList(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
