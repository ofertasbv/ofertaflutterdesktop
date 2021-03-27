import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/cliente_controller.dart';
import 'package:nosso/src/core/model/cliente.dart';
import 'package:nosso/src/paginas/cliente/cliente_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class ClienteTable extends StatefulWidget {
  @override
  _ClienteTableState createState() => _ClienteTableState();
}

class _ClienteTableState extends State<ClienteTable>
    with AutomaticKeepAliveClientMixin<ClienteTable> {
  var clienteController = GetIt.I.get<ClienteController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    clienteController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return clienteController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      clienteController.getAll();
    } else {
      nome = nomeController.text;
      clienteController.getAllByNome(nome);
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
          List<Cliente> clientes = clienteController.clientes;
          if (clienteController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (clientes == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(clientes),
          );
        },
      ),
    );
  }

  buildTable(List<Cliente> clientes) {
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
            DataColumn(label: Text("Código")),
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Telefone")),
            DataColumn(label: Text("Cpf")),
            DataColumn(label: Text("Editar")),
            DataColumn(label: Text("Detalhes")),
            DataColumn(label: Text("Pedidos")),
            DataColumn(label: Text("Endereços")),
          ],
          source: DataSource(clientes, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var clienteController = GetIt.I.get<ClienteController>();
  BuildContext context;
  List<Cliente> clientes;
  int selectedCount = 0;

  DataSource(this.clientes, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= clientes.length) return null;
    Cliente p = clientes[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(CircleAvatar(
          backgroundColor: Colors.grey[200],
          radius: 20,
        )),
        DataCell(Text("${p.nome}")),
        DataCell(Text("${p.telefone}")),
        DataCell(Text("${p.usuario.email}")),
        DataCell(Text(p.cpf)),
        DataCell(IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ClienteCreatePage(
                    cliente: p,
                  );
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ClienteCreatePage(
                    cliente: p,
                  );
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.shopping_basket_outlined),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ClienteCreatePage(
                    cliente: p,
                  );
                },
              ),
            );
          },
        )),
        DataCell(IconButton(
          icon: Icon(Icons.location_on_outlined),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ClienteCreatePage(
                    cliente: p,
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
  int get rowCount => clientes.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
