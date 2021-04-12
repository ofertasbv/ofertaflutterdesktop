import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/caixafluxosaida_controller.dart';
import 'package:nosso/src/core/model/caixasaida.dart';
import 'package:nosso/src/paginas/caixafluxosaida/caixafluxosaida_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class CaixaFluxoSaidaList extends StatefulWidget {
  @override
  _CaixaFluxoSaidaListState createState() => _CaixaFluxoSaidaListState();
}

class _CaixaFluxoSaidaListState extends State<CaixaFluxoSaidaList>
    with AutomaticKeepAliveClientMixin<CaixaFluxoSaidaList> {
  var caixafluxosaidaController = GetIt.I.get<CaixafluxosaidaController>();

  @override
  void initState() {
    caixafluxosaidaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return caixafluxosaidaController.getAll();
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
          List<CaixaFluxoSaida> saidas = caixafluxosaidaController.caixaSaidas;
          if (caixafluxosaidaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (saidas == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(saidas),
          );
        },
      ),
    );
  }

  buildTable(List<CaixaFluxoSaida> saidas) {
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
          source: DataSource(saidas, context),
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
  List<CaixaFluxoSaida> saidas;
  int selectedCount = 0;
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  DataSource(this.saidas, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= saidas.length) return null;
    CaixaFluxoSaida p = saidas[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.descricao}")),
        DataCell(Text("${p.caixaFluxo.descricao}")),
        DataCell(Text(
          "R\$ ${formatMoeda.format(p.valorSaida)}",
          style: TextStyle(color: Colors.red),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CaixaFluxoSaidaCreatePage(
                      saida: p,
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
                    return CaixaFluxoSaidaCreatePage(
                      saida: p,
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
  int get rowCount => saidas.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}

