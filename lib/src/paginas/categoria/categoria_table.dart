import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/paginas/categoria/categoria_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class CategoriaTable extends StatefulWidget {
  @override
  _CategoriaTableState createState() => _CategoriaTableState();
}

class _CategoriaTableState extends State<CategoriaTable>
    with AutomaticKeepAliveClientMixin<CategoriaTable> {
  var categoriaController = GetIt.I.get<CategoriaController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    categoriaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return categoriaController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      categoriaController.getAll();
    } else {
      nome = nomeController.text;
      categoriaController.getAllByNome(nome);
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
          List<Categoria> categorias = categoriaController.categorias;
          if (categoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (categorias == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(categorias),
          );
        },
      ),
    );
  }

  buildTable(List<Categoria> categorias) {
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
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Color")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(categorias, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var categoriaController = GetIt.I.get<CategoriaController>();
  BuildContext context;
  List<Categoria> categorias;
  int selectedCount = 0;

  DataSource(this.categorias, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= categorias.length) return null;
    Categoria p = categorias[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(
          p.foto != null
              ? CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "${categoriaController.arquivo + p.foto}",
                  ),
                )
              : CircleAvatar(),
        ),
        DataCell(Text("${p.nome}")),
        DataCell(Text(p.color.toString())),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoriaCreatePage(
                    categoria: p,
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
                  return CategoriaCreatePage(
                    categoria: p,
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
  int get rowCount => categorias.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
