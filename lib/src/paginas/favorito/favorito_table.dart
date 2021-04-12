import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/favorito_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/favorito.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class FavoritoTable extends StatefulWidget {
  @override
  _FavoritoTableState createState() => _FavoritoTableState();
}

class _FavoritoTableState extends State<FavoritoTable>
    with AutomaticKeepAliveClientMixin<FavoritoTable> {
  var favoritoController = GetIt.I.get<FavoritoController>();
  var produtoController = GetIt.I.get<ProdutoController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    favoritoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return favoritoController.getAll();
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
          List<Favorito> favoritos = favoritoController.favoritos;
          if (favoritoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (favoritos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(favoritos),
          );
        },
      ),
    );
  }

  buildTable(List<Favorito> favoritos) {
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
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Produto")),
            DataColumn(label: Text("Cliente")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(favoritos, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var produtoController = GetIt.I.get<ProdutoController>();
  BuildContext context;
  List<Favorito> favoritos;
  int selectedCount = 0;
  var dateFormat = DateFormat('dd/MM/yyyy');

  DataSource(this.favoritos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= favoritos.length) return null;
    Favorito p = favoritos[index];
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
        DataCell(Text(p.cliente.nome)),
        DataCell(Text("${p.status}")),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        )),
      ],
    );
  }

  @override
  int get rowCount => favoritos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
