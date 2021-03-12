import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PedidoItemTable extends StatefulWidget {
  @override
  _PedidoItemTableState createState() => _PedidoItemTableState();
}

class _PedidoItemTableState extends State<PedidoItemTable>
    with AutomaticKeepAliveClientMixin<PedidoItemTable> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var produtoController = GetIt.I.get<ProdutoController>();

  @override
  void initState() {
    pedidoItemController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return pedidoItemController.getAll();
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
          List<PedidoItem> itens = pedidoItemController.pedidoItens;
          if (pedidoItemController.error != null) {
            return Text("Não foi possível buscar permissões");
          }

          if (itens == null) {
            return Center(
              child: CircularProgressor(),
            );
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderTable(itens),
          );
        },
      ),
    );
  }

  builderTable(List<PedidoItem> itens) {
    return DataTable(
      sortAscending: true,
      showCheckboxColumn: true,
      showBottomBorder: true,
      columnSpacing: 100,
      columns: [
        DataColumn(label: Text("Código")),
        DataColumn(label: Text("Foto")),
        DataColumn(label: Text("Produto")),
        DataColumn(label: Text("Quant.")),
        DataColumn(label: Text("Valor unit.")),
        DataColumn(label: Text("Valor total.")),
        DataColumn(label: Text("Visualizar")),
        DataColumn(label: Text("Editar")),
      ],
      rows: itens
          .map(
            (p) => DataRow(
              onSelectChanged: (i) {
                setState(() {
                  // selecionaItem(p);
                });
              },
              cells: [
                DataCell(Text("${p.id}")),
                DataCell(CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "${produtoController.arquivo + p.produto.foto}",
                  ),
                )),
                DataCell(Text("${p.produto.nome}")),
                DataCell(Text(
                  "${p.quantidade}",
                  style: TextStyle(color: Colors.black),
                )),
                DataCell(Text(
                  "${p.valorTotal}",
                  style: TextStyle(color: Colors.red),
                )),
                DataCell(Text(
                  "${p.valorUnitario}",
                  style: TextStyle(color: Colors.red),
                )),
                DataCell(IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return PedidoItemCreatePage(
                            pedidoItem: p,
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
                          return PedidoItemCreatePage(
                            pedidoItem: p,
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
