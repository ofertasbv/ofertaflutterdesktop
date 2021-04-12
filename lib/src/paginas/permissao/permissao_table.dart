import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/permissao_controller.dart';
import 'package:nosso/src/core/model/permissao.dart';
import 'package:nosso/src/paginas/permissao/permissao_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PermissaoTable extends StatefulWidget {
  @override
  _PermissaoTableState createState() => _PermissaoTableState();
}

class _PermissaoTableState extends State<PermissaoTable>
    with AutomaticKeepAliveClientMixin<PermissaoTable> {
  var permissaoController = GetIt.I.get<PermissaoController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    permissaoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return permissaoController.getAll();
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
          List<Permissao> permissoes = permissaoController.permissoes;
          if (permissaoController.error != null) {
            return Text("Não foi possível buscar permissões");
          }

          if (permissoes == null) {
            return Center(
              child: CircularProgressor(),
            );
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(permissoes),
          );
        },
      ),
    );
  }

  buildTable(List<Permissao> permissoes) {
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
          ],
          source: DataSource(permissoes, context),
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
  List<Permissao> permissoes;
  int selectedCount = 0;
  var dateFormat = DateFormat('dd/MM/yyyy');

  DataSource(this.permissoes, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= permissoes.length) return null;
    Permissao p = permissoes[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.descricao}")),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return PermissaoCreatePage(
                      permissao: p,
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
                    return PermissaoCreatePage(
                      permissao: p,
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
  int get rowCount => permissoes.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
