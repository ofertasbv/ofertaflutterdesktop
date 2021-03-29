import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/cor_controller.dart';
import 'package:nosso/src/core/model/cor.dart';
import 'package:nosso/src/paginas/cor/cor_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class CorTable extends StatefulWidget {
  @override
  _CorTableState createState() => _CorTableState();
}

class _CorTableState extends State<CorTable>
    with AutomaticKeepAliveClientMixin<CorTable> {
  var corController = GetIt.I.get<CorController>();

  @override
  void initState() {
    corController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return corController.getAll();
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
          List<Cor> cores = corController.cores;
          if (corController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (cores == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(cores),
          );
        },
      ),
    );
  }

  buildTable(List<Cor> cores) {
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
            DataColumn(label: Text("Color")),
            DataColumn(label: Text("Descrição")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(cores, context),
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
  List<Cor> cores;
  int selectedCount = 0;
  var dateFormat = DateFormat('dd/MM/yyyy');

  DataSource(this.cores, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= cores.length) return null;
    Cor p = cores[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 20,
        )),
        DataCell(Text("${p.descricao}")),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CorCreatePage(
                    cor: p,
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
                  return CorCreatePage(
                    cor: p,
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
  int get rowCount => cores.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
