import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/tamanho_controller.dart';
import 'package:nosso/src/core/model/tamanho.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class TamanhoTable extends StatefulWidget {
  @override
  _TamanhoTableState createState() => _TamanhoTableState();
}

class _TamanhoTableState extends State<TamanhoTable>
    with AutomaticKeepAliveClientMixin<TamanhoTable> {
  var tamanhoController = GetIt.I.get<TamanhoController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    tamanhoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return tamanhoController.getAll();
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
          List<Tamanho> tamanhos = tamanhoController.tamanhos;
          if (tamanhoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (tamanhos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(tamanhos),
          );
        },
      ),
    );
  }

  buildTable(List<Tamanho> tamanhos) {
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
            DataColumn(label: Text("Código")),
            DataColumn(label: Text("Descrição")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(tamanhos, context),
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
  List<Tamanho> tamanhos;
  int selectedCount = 0;
  var dateFormat = DateFormat('dd/MM/yyyy');

  DataSource(this.tamanhos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= tamanhos.length) return null;
    Tamanho p = tamanhos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.descricao}")),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TamanhoCreatePage(
                    tamanho: p,
                  );
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TamanhoCreatePage(
                    tamanho: p,
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
  int get rowCount => tamanhos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
