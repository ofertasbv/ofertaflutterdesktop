import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/caixafluxoentrada_controller.dart';
import 'package:nosso/src/core/model/caixaentrada.dart';
import 'package:nosso/src/paginas/caixafluxoentrada/caixafluxoentrada_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class CaixaFluxoEntradaList extends StatefulWidget {
  @override
  _CaixaFluxoEntradaListState createState() => _CaixaFluxoEntradaListState();
}

class _CaixaFluxoEntradaListState extends State<CaixaFluxoEntradaList>
    with AutomaticKeepAliveClientMixin<CaixaFluxoEntradaList> {
  var caixafluxoentradaController = GetIt.I.get<CaixafluxoentradaController>();

  @override
  void initState() {
    caixafluxoentradaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return caixafluxoentradaController.getAll();
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
          List<CaixaFluxoEntrada> entradas =
              caixafluxoentradaController.caixaEntradas;
          if (caixafluxoentradaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (entradas == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(entradas),
          );
        },
      ),
    );
  }

  buildTable(List<CaixaFluxoEntrada> caixaFluxosEntradas) {
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
            DataColumn(label: Text("Caixa fluxo")),
            DataColumn(label: Text("Total")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(caixaFluxosEntradas, context),
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
  List<CaixaFluxoEntrada> caixaFluxosEntradas;
  int selectedCount = 0;
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  DataSource(this.caixaFluxosEntradas, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= caixaFluxosEntradas.length) return null;
    CaixaFluxoEntrada p = caixaFluxosEntradas[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.descricao}")),
        DataCell(Text("${p.caixaFluxo.descricao}")),
        DataCell(Text(
          "R\$ ${formatMoeda.format(p.valorEntrada)}",
          style: TextStyle(color: Colors.red),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CaixaFluxoEntradaCreatePage(
                      entrada: p,
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
                    return CaixaFluxoEntradaCreatePage(
                      entrada: p,
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
  int get rowCount => caixaFluxosEntradas.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
