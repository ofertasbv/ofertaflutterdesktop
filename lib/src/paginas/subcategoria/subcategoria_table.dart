import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class SubCategoriaTable extends StatefulWidget {
  @override
  _SubCategoriaTableState createState() => _SubCategoriaTableState();
}

class _SubCategoriaTableState extends State<SubCategoriaTable>
    with AutomaticKeepAliveClientMixin<SubCategoriaTable> {
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    subCategoriaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return subCategoriaController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      subCategoriaController.getAll();
    } else {
      nome = nomeController.text;
      subCategoriaController.getAllByNome(nome);
    }
  }

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
                onChanged: filterByNome,
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
          List<SubCategoria> subcategorias =
              subCategoriaController.subCategorias;
          if (subCategoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (subcategorias == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(subcategorias),
          );
        },
      ),
    );
  }

  buildTable(List<SubCategoria> subcategorias) {
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
            DataColumn(label: Text("Categoria")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Categorias")),
          ],
          source: DataSource(subcategorias, context),
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
  List<SubCategoria> subcategorias;
  int selectedCount = 0;

  DataSource(this.subcategorias, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= subcategorias.length) return null;
    SubCategoria p = subcategorias[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text("${p.id}"),
        ),
        DataCell(
          Text("${p.nome}"),
        ),
        DataCell(
          Text("${p.categoria.nome}"),
        ),
        DataCell(IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SubCategoriaCreatePage(
                    subCategoria: p,
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
                  return SubCategoriaCreatePage(
                    subCategoria: p,
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
  int get rowCount => subcategorias.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
