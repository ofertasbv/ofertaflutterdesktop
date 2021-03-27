import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_create_page.dart';
import 'package:nosso/src/paginas/pedido/pedido_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PedidoTable extends StatefulWidget {
  @override
  _PedidoTableState createState() => _PedidoTableState();
}

class _PedidoTableState extends State<PedidoTable> {
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

          return buildTable(pedidos);
        },
      ),
    );
  }

  buildTable(List<Pedido> pedidos) {
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
            DataColumn(label: Text("Descrição.")),
            DataColumn(label: Text("Valor")),
            DataColumn(label: Text("Cliente")),
            DataColumn(label: Text("Loja")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Itens")),
            DataColumn(label: Text("Pagamento")),
          ],
          source: DataSource(pedidos, context),
        ),
      ],
    );
  }
}

class DataSource extends DataTableSource {
  var pedidoController = GetIt.I.get<PedidoController>();
  BuildContext context;
  List<Pedido> pedidos;
  int selectedCount = 0;

  DataSource(this.pedidos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= pedidos.length) return null;
    Pedido p = pedidos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.descricao}")),
        DataCell(Text(
          "${p.valorDesconto}",
          style: TextStyle(color: Colors.red),
        )),
        DataCell(Text("${p.cliente.nome}")),
        DataCell(Text("${p.loja.nome}")),
        DataCell(Text("${p.pedidoStatus}")),
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
        DataCell(IconButton(
          icon: Icon(Icons.shopping_basket_outlined),
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
          icon: Icon(Icons.credit_card_outlined),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PagamentoCreatePage();
                },
              ),
            );
          },
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
