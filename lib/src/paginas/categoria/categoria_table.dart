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

  @override
  void initState() {
    categoriaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return categoriaController.getAll();
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
          List<Categoria> categorias = categoriaController.categorias;
          if (categoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (categorias == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderTable(categorias),
          );
        },
      ),
    );
  }

  builderTable(List<Categoria> categorias) {
    return DataTable(
      sortAscending: true,
      showCheckboxColumn: true,
      showBottomBorder: true,
      columns: [
        DataColumn(label: Text("Código")),
        DataColumn(label: Text("Nome")),
        DataColumn(label: Text("Foto")),
        DataColumn(label: Text("Color")),
        DataColumn(label: Text("Editar")),
      ],
      rows: categorias
          .map(
            (p) => DataRow(
              onSelectChanged: (i) {
                setState(() {
                  // selecionaItem(p);
                });
              },
              cells: [
                DataCell(
                  Text("${p.id}"),
                ),
                DataCell(
                  Text("${p.nome}"),
                ),
                DataCell(
                  Text("${p.foto}"),
                ),
                DataCell(Text(p.color)),
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
            ),
          )
          .toList(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
