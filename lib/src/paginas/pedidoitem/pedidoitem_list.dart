import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PedidoItemList extends StatefulWidget {
  @override
  _PedidoItemListState createState() => _PedidoItemListState();
}

class _PedidoItemListState extends State<PedidoItemList> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();

  @override
  void initState() {
    pedidoItemController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    pedidoItemController.getAll();
  }

  @override
  Widget build(BuildContext context) {
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

          return buildTable(itens);
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
          columns: [
            DataColumn(label: Text("Id")),
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Produto")),
            DataColumn(label: Text("Valor unit.")),
            DataColumn(label: Text("Valor total")),
            DataColumn(label: Text("Quantidade")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(itens, context),
        ),
      ],
    );
  }

  showDialogAlert(BuildContext context, PedidoItem p) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('INFORMAÇÃOES'),
          content: Text(p.produto.nome),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('EDITAR'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return PedidoItemCreatePage(pedidoItem: p);
                    },
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


class DataSource extends DataTableSource {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var produtoController = GetIt.I.get<ProdutoController>();
  BuildContext context;
  List<PedidoItem> pedidoItens;
  int selectedCount = 0;

  DataSource(this.pedidoItens, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= pedidoItens.length) return null;
    PedidoItem p = pedidoItens[index];
    return DataRow.byIndex(
      index: index,
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
          "${p.valorUnitario}",
          style: TextStyle(color: Colors.red),
        )),
        DataCell(Text(
          "${p.valorTotal}",
          style: TextStyle(color: Colors.red),
        )),
        DataCell(Text("${p.quantidade}")),
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
    );
  }

  @override
  int get rowCount => pedidoItens.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
