import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixa_controller.dart';
import 'package:nosso/src/core/model/caixa.dart';
import 'package:nosso/src/paginas/caixa/caixa_create_page.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class CaixaTable extends StatefulWidget {
  @override
  _CaixaTableState createState() => _CaixaTableState();
}

class _CaixaTableState extends State<CaixaTable>
    with AutomaticKeepAliveClientMixin<CaixaTable> {
  var caixaController = GetIt.I.get<CaixaController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    caixaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return caixaController.getAll();
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
          List<Caixa> caixas = caixaController.caixas;
          if (caixaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (caixas == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(caixas),
          );
        },
      ),
    );
  }

  buildTable(List<Caixa> caixas) {
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
            DataColumn(label: Text("Descrição")),
            DataColumn(label: Text("Caixa")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Abertura")),
            DataColumn(label: Text("Fechamento")),
          ],
          source: DataSource(caixas, context),
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
  List<Caixa> caixas;
  int selectedCount = 0;

  DataSource(this.caixas, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= caixas.length) return null;
    Caixa p = caixas[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.descricao}")),
        DataCell(Text("${p.referencia}")),
        DataCell(CircleAvatar(
          backgroundColor:
              p.caixaStatus == "ABERTO" ? Colors.green[600] : Colors.red[600],
          child: Text("${p.caixaStatus.substring(0, 1)}"),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CaixaCreatePage(
                      caixa: p,
                    );
                  },
                ),
              );
            },
          ),
        )),
        DataCell(RaisedButton.icon(
          label: Text("Abrir caixa"),
          color: p.caixaStatus == "FECHADO" ? Colors.green[600] : Colors.red[600],
          icon: Icon(Icons.edit),
          onPressed: p.caixaStatus == "FECHADO"
              ? () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return CaixaFluxoCreatePage(
                          caixa: p,
                        );
                      },
                    ),
                  );
                }
              : null,
        )),
        DataCell(RaisedButton.icon(
          label: Text("Fechar caixa"),
          icon: Icon(Icons.edit),
          color: p.caixaStatus == "ABERTO" ? Colors.red[600] : Colors.green[600],
          onPressed: p.caixaStatus == "ABERTO"
              ? () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaFluxoCreatePage(
                    caixa: p,
                  );
                },
              ),
            );
          }
              : null,
        )),
      ],
    );
  }

  @override
  int get rowCount => caixas.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
