import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixafluxo_controller.dart';
import 'package:nosso/src/core/model/caixafluxo.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class CaixaFluxoTable extends StatefulWidget {
  @override
  _CaixaFluxoTableState createState() => _CaixaFluxoTableState();
}

class _CaixaFluxoTableState extends State<CaixaFluxoTable>
    with AutomaticKeepAliveClientMixin<CaixaFluxoTable> {
  var caixafluxoController = GetIt.I.get<CaixafluxoController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    caixafluxoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return caixafluxoController.getAll();
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
            padding: EdgeInsets.all(5),
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
          List<CaixaFluxo> caixaFluxos = caixafluxoController.caixaFluxos;
          if (caixafluxoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (caixaFluxos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(caixaFluxos),
          );
        },
      ),
    );
  }

  buildTable(List<CaixaFluxo> caixaFluxos) {
    return ListView(
      children: [
        PaginatedDataTable(
          rowsPerPage: 8,
          showCheckboxColumn: true,
          sortColumnIndex: 1,
          sortAscending: true,
          showFirstLastButtons: true,
          columns: [
            DataColumn(label: Text("Código")),
            DataColumn(label: Text("Descrição")),
            DataColumn(label: Text("Caixa")),
            DataColumn(label: Text("Caixa Status")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(caixaFluxos, context),
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
  List<CaixaFluxo> caixaFluxos;
  int selectedCount = 0;

  DataSource(this.caixaFluxos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= caixaFluxos.length) return null;
    CaixaFluxo p = caixaFluxos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.descricao}")),
        DataCell(Text("${p.caixa.descricao}")),
        DataCell(Text("${p.caixa.caixaStatus}")),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaFluxoCreatePage(
                    caixaFluxo: p,
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
                  return CaixaFluxoCreatePage(
                    caixaFluxo: p,
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
  int get rowCount => caixaFluxos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
