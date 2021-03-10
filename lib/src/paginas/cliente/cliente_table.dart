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
          List<Cliente> clientes = clienteController.clientes;
          if (clienteController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (clientes == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderTable(clientes),
          );
        },
      ),
    );
  }

  builderTable(List<Cliente> clientes) {
    return DataTable(
      sortAscending: true,
      showCheckboxColumn: true,
      showBottomBorder: true,
      columns: [
        DataColumn(label: Text("Código")),
        DataColumn(label: Text("Nome")),
        DataColumn(label: Text("Email")),
        DataColumn(label: Text("Cpf")),
        DataColumn(label: Text("Editar")),
        DataColumn(label: Text("Detalhes")),
      ],
      rows: clientes
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
                  Text("${p.usuario.email}"),
                ),
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
