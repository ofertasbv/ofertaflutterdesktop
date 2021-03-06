import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/core/model/vendedor.dart';
import 'package:nosso/src/paginas/vendedor/vendedor_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class VendedorTable extends StatefulWidget {
  @override
  _VendedorTableState createState() => _VendedorTableState();
}

class _VendedorTableState extends State<VendedorTable>
    with AutomaticKeepAliveClientMixin<VendedorTable> {
  var vendedorController = GetIt.I.get<VendedorController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    vendedorController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return vendedorController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      vendedorController.getAll();
    } else {
      nome = nomeController.text;
      vendedorController.getAllByNome(nome);
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
          List<Vendedor> vendedores = vendedorController.vendedores;
          if (vendedorController.error != null) {
            return Text("N??o foi poss??vel carregados dados");
          }

          if (vendedores == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(vendedores),
          );
        },
      ),
    );
  }

  buildTable(List<Vendedor> vendedores) {
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
            DataColumn(label: Text("C??d.")),
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Telefone")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Detalhes")),
            DataColumn(label: Text("Pedidos")),
            DataColumn(label: Text("Endere??os")),
          ],
          source: DataSource(vendedores, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var vendedorController = GetIt.I.get<VendedorController>();
  BuildContext context;
  List<Vendedor> vendedores;
  int selectedCount = 0;

  DataSource(this.vendedores, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= vendedores.length) return null;
    Vendedor p = vendedores[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(CircleAvatar(
          child: Icon(Icons.person),
          backgroundColor: Colors.grey[200],
          radius: 20,
        )),
        DataCell(Text("${p.nome}")),
        DataCell(Text("${p.telefone}")),
        DataCell(Text("${p.usuario.email}")),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return VendedorCreatePage(
                      vendedor: p,
                    );
                  },
                ),
              );
            },
          ),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return VendedorCreatePage(
                      vendedor: p,
                    );
                  },
                ),
              );
            },
          ),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.shopping_basket_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return VendedorCreatePage(
                      vendedor: p,
                    );
                  },
                ),
              );
            },
          ),
        )),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.location_on_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return VendedorCreatePage(
                      vendedor: p,
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
  int get rowCount => vendedores.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
