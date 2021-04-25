import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_create_page.dart';
import 'package:nosso/src/util/filter/pedidoitem_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PedidoItemTable extends StatefulWidget {
  PedidoItemFilter pedidoItemFilter;

  PedidoItemTable({Key key, this.pedidoItemFilter}) : super(key: key);

  @override
  _PedidoItemTableState createState() =>
      _PedidoItemTableState(filter: this.pedidoItemFilter);
}

class _PedidoItemTableState extends State<PedidoItemTable>
    with AutomaticKeepAliveClientMixin<PedidoItemTable> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var produtoController = GetIt.I.get<ProdutoController>();
  var nomeController = TextEditingController();

  _PedidoItemTableState({this.filter});

  PedidoItemFilter filter;

  @override
  void initState() {
    if (filter == null) {
      filter = PedidoItemFilter();
      pedidoItemController.getAll();
    } else {
      pedidoItemController.getFilter(filter);
    }
    super.initState();
  }

  Future<void> onRefresh() {
    return pedidoItemController.getAll();
  }

  bool isLoading = true;

  pesquisarFilter() {
    print("pesquisa produto: ${filter.nome}");
    print("pesquisa pedido: ${filter.pedido}");
    print("pesquisa...");
    pedidoItemController.getFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: Text("Itens de pedido"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (pedidoItemController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (pedidoItemController.pedidoItens == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Text(
                  (pedidoItemController.pedidoItens.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                pedidoItemController.getAll();
                filter = PedidoItemFilter();
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: builderConteudoList(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return PedidoItemCreatePage();
            }),
          );
        },
      ),
    );
  }

  builderConteudoList() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            color: Colors.grey[100],
            padding: EdgeInsets.all(0),
            child: TextFormField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: "busca por nome",
                prefixIcon: Icon(Icons.search_outlined),
                suffixIcon: IconButton(
                  onPressed: () => nomeController.clear(),
                  icon: Icon(Icons.clear),
                ),
              ),
              onChanged: (nome) {
                filter.nome = nomeController.text;
                print("produto nome: ${nome}");
                print("produto filter: ${filter.nome}");
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton.icon(
                  onPressed: () {
                    pesquisarFilter();
                  },
                  icon: Icon(Icons.search),
                  label: Text("Realizar pesquisa"),
                ),
                RaisedButton.icon(
                  onPressed: () {
                    produtoController.getAll();
                    filter = PedidoItemFilter();
                  },
                  icon: Icon(Icons.refresh),
                  label: Text("Atualizar pesquisa"),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: buildContainer(),
            ),
          ),
        ],
      ),
    );
  }

  Container buildContainer() {
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
            child: buildTable(itens),
          );
        },
      ),
    );
  }

  buildTable(List<PedidoItem> itens) {
    return ListView(
      children: [
        PaginatedDataTable(
          rowsPerPage: 8,
          showCheckboxColumn: true,
          sortColumnIndex: 1,
          sortAscending: true,
          showFirstLastButtons: true,
          columnSpacing: 10,
          columns: [
            DataColumn(label: Text("Cód")),
            DataColumn(label: Text("Cód de barra")),
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Produto")),
            DataColumn(label: Text("Pedido")),
            DataColumn(label: Text("Quant.")),
            DataColumn(label: Text("Valor unit.")),
            DataColumn(label: Text("Valor total.")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(itens, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var produtoController = GetIt.I.get<ProdutoController>();
  BuildContext context;
  List<PedidoItem> pedidos;
  int selectedCount = 0;

  DataSource(this.pedidos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= pedidos.length) return null;
    PedidoItem p = pedidos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.produto.codigoBarra}")),
        DataCell(
          p.produto.foto != null
              ? CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: 20,
                  backgroundImage: NetworkImage(
                      "${produtoController.arquivo + p.produto.foto}"),
                )
              : CircleAvatar(
                  child: Icon(Icons.photo),
                ),
        ),
        DataCell(Text("${p.produto.nome}")),
        DataCell(Text("${p.pedido.descricao}")),
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
        DataCell(CircleAvatar(
          child: IconButton(
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
          ),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
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
          ),
        )),
      ],
    );
  }

  @override
  int get rowCount => pedidos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
