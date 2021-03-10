import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/marca_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/marca.dart';
import 'package:nosso/src/paginas/marca/marca_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class MarcaTable extends StatefulWidget {
  @override
  _MarcaTableState createState() => _MarcaTableState();
}

class _MarcaTableState extends State<MarcaTable>
    with AutomaticKeepAliveClientMixin<MarcaTable> {
  var marcaController = GetIt.I.get<MarcaController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    marcaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return marcaController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      marcaController.getAll();
    } else {
      nome = nomeController.text;
      marcaController.getAllByNome(nome);
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
            height: 80,
            width: double.infinity,
            color: Colors.grey[100],
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
          List<Marca> marcas = marcaController.marcas;
          if (marcaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (marcas == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderTable(marcas),
          );
        },
      ),
    );
  }

  builderTable(List<Marca> marcas) {
    return DataTable(
      sortAscending: true,
      showCheckboxColumn: true,
      showBottomBorder: true,
      columnSpacing: 250,
      columns: [
        DataColumn(label: Text("Código")),
        DataColumn(label: Text("Nome")),
        DataColumn(label: Text("Visualizar")),
        DataColumn(label: Text("Editar")),
        DataColumn(label: Text("Produtos")),
      ],
      rows: marcas
          .map(
            (p) => DataRow(
              onSelectChanged: (i) {
                setState(() {
                  // selecionaItem(p);
                });
              },
              cells: [
                DataCell(Text("${p.id}")),
                DataCell(Text("${p.nome}")),
                DataCell(IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return MarcaCreatePage(
                            marca: p,
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
                          return MarcaCreatePage(
                            marca: p,
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
                          return MarcaCreatePage(
                            marca: p,
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
