import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/marca_controller.dart';
import 'package:nosso/src/core/model/marca.dart';
import 'package:nosso/src/paginas/marca/marca_create_page.dart';
import 'package:nosso/src/paginas/produto/produto_table.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
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
          List<Marca> marcas = marcaController.marcas;
          if (marcaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (marcas == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(marcas),
          );
        },
      ),
    );
  }

  buildTable(List<Marca> marcas) {
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
            DataColumn(label: Text("Produtos")),
          ],
          source: DataSource(marcas, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var marcaController = GetIt.I.get<MarcaController>();
  BuildContext context;
  List<Marca> marcas;
  int selectedCount = 0;
  var dateFormat = DateFormat('dd/MM/yyyy');

  DataSource(this.marcas, this.context);

  ProdutoFilter filter = ProdutoFilter();

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= marcas.length) return null;
    Marca p = marcas[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.nome}")),
        DataCell(CircleAvatar(
          child: IconButton(
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
          ),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
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
          ),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.list_alt_outlined),
            onPressed: () {
              filter.promocao = p.id;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProdutoTable(filter: this.filter);
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
  int get rowCount => marcas.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
