import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/promocaotipo_controller.dart';
import 'package:nosso/src/core/model/promocaotipo.dart';
import 'package:nosso/src/paginas/promocaotipo/promocaotipo_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PromocaoTipoTable extends StatefulWidget {
  @override
  _PromocaoTipoTableState createState() => _PromocaoTipoTableState();
}

class _PromocaoTipoTableState extends State<PromocaoTipoTable>
    with AutomaticKeepAliveClientMixin<PromocaoTipoTable> {
  var promocaoTipoController = GetIt.I.get<PromocaoTipoController>();

  @override
  void initState() {
    promocaoTipoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return promocaoTipoController.getAll();
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
          List<PromocaoTipo> promocaoTipos =
              promocaoTipoController.promocaoTipos;
          if (promocaoTipoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (promocaoTipos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderTable(promocaoTipos),
          );
        },
      ),
    );
  }

  builderTable(List<PromocaoTipo> promocaoTipos) {
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
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Promoções")),
          ],
          source: DataSource(promocaoTipos, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var promocaoTipoController = GetIt.I.get<PromocaoTipoController>();
  BuildContext context;
  List<PromocaoTipo> promocaoTipos;
  int selectedCount = 0;
  var dateFormat = DateFormat('dd/MM/yyyy');

  DataSource(this.promocaoTipos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= promocaoTipos.length) return null;
    PromocaoTipo p = promocaoTipos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.descricao}")),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoTipoCreatePage(
                    promocaoTipo: p,
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
                  return PromocaoTipoCreatePage(
                    promocaoTipo: p,
                  );
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoTipoCreatePage(
                    promocaoTipo: p,
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
  int get rowCount => promocaoTipos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
