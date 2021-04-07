import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/pagamento_controller.dart';
import 'package:nosso/src/core/model/pagamento.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PagamentoTable extends StatefulWidget {
  @override
  _PagamentoTableState createState() => _PagamentoTableState();
}

class _PagamentoTableState extends State<PagamentoTable>
    with AutomaticKeepAliveClientMixin<PagamentoTable> {
  var pagamentoController = GetIt.I.get<PagamentoController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    pagamentoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return pagamentoController.getAll();
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 0),
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.grey[200],
            padding: EdgeInsets.all(0),
            child: ListTile(
              subtitle: TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "busca por nome",
                  prefixIcon: Icon(Icons.search_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => nomeController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: builderConteudoList(),
            ),
          ),
        ],
      ),
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Pagamento> pagamentos = pagamentoController.pagamentos;
          if (pagamentoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (pagamentos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(pagamentos),
          );
        },
      ),
    );
  }

  buildTable(List<Pagamento> pagamentos) {
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
            DataColumn(label: Text("Cód.")),
            DataColumn(label: Text("Quantidade")),
            DataColumn(label: Text("Forma")),
            DataColumn(label: Text("Tipo")),
            DataColumn(label: Text("Valor")),
            DataColumn(label: Text("Registro")),
            DataColumn(label: Text("Pedido")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Faturas")),
          ],
          source: DataSource(pagamentos, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  BuildContext context;
  List<Pagamento> pagamentos;
  int selectedCount = 0;
  var dateFormat = DateFormat('dd/MM/yyyy');
  var numberFormat = NumberFormat("00.00");

  DataSource(this.pagamentos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= pagamentos.length) return null;
    Pagamento p = pagamentos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.quantidade}")),
        DataCell(Text(p.pagamentoForma)),
        DataCell(Text("${p.pagamentoTipo}")),
        DataCell(Text("${numberFormat.format(p.valor)}")),
        DataCell(Text("${dateFormat.format(p.dataPagamento)}")),
        DataCell(Text("${p.pedido.descricao}")),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PagamentoCreatePage(
                    pagamento: p,
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
                  return PagamentoCreatePage(
                    pagamento: p,
                  );
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.monetization_on_outlined),
          onPressed: () {},
        )),
      ],
    );
  }

  @override
  int get rowCount => pagamentos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
