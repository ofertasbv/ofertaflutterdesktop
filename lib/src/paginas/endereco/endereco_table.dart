import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/controller/endereco_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/endereco.dart';
import 'package:nosso/src/paginas/categoria/categoria_create_page.dart';
import 'package:nosso/src/paginas/endereco/endereco_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class EnderecoTable extends StatefulWidget {
  @override
  _EnderecoTableState createState() => _EnderecoTableState();
}

class _EnderecoTableState extends State<EnderecoTable>
    with AutomaticKeepAliveClientMixin<EnderecoTable> {
  var enderecoController = GetIt.I.get<EnderecoController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    enderecoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return enderecoController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      // categoriaController.getAll();
    } else {
      nome = nomeController.text;
      // categoriaController.getAllByNome(nome);
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
          List<Endereco> enderecos = enderecoController.enderecos;
          if (enderecoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (enderecos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(enderecos),
          );
        },
      ),
    );
  }

  buildTable(List<Endereco> enderecos) {
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
            DataColumn(label: Text("Logradouro")),
            DataColumn(label: Text("Número")),
            DataColumn(label: Text("Complemnto")),
            DataColumn(label: Text("Bairro")),
            DataColumn(label: Text("Cep")),
            DataColumn(label: Text("Cidade")),
            DataColumn(label: Text("Visualisar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(enderecos, context),
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
  List<Endereco> enderecos;
  int selectedCount = 0;

  DataSource(this.enderecos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= enderecos.length) return null;
    Endereco p = enderecos[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.logradouro}")),
        DataCell(Text("${p.numero}")),
        DataCell(Text(p.complemento)),
        DataCell(Text(p.bairro)),
        DataCell(Text(p.cep)),
        DataCell(Text(p.cidade.nome)),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return EnderecoCreatePage(
                    endereco: p,
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
                  return EnderecoCreatePage(
                    endereco: p,
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
  int get rowCount => enderecos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
