import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/core/model/usuario.dart';
import 'package:nosso/src/paginas/usuario/usuario_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class UsuarioTable extends StatefulWidget {
  @override
  _UsuarioTableState createState() => _UsuarioTableState();
}

class _UsuarioTableState extends State<UsuarioTable>
    with AutomaticKeepAliveClientMixin<UsuarioTable> {
  var usuarioController = GetIt.I.get<UsuarioController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    usuarioController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return usuarioController.getAll();
  }

  bool isLoading = true;

  filterByNome(String email) {
    if (email.trim().isEmpty) {
      usuarioController.getAll();
    } else {
      email = nomeController.text;
      usuarioController.getEmail(email);
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
          List<Usuario> usuarios = usuarioController.usuarios;
          if (usuarioController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (usuarios == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: buildTable(usuarios),
          );
        },
      ),
    );
  }

  buildTable(List<Usuario> usuarios) {
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
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(usuarios, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var usuarioController = GetIt.I.get<UsuarioController>();
  BuildContext context;
  List<Usuario> usuarios;
  int selectedCount = 0;

  DataSource(this.usuarios, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= usuarios.length) return null;
    Usuario p = usuarios[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.id}")),
        DataCell(Text("${p.email}")),
        DataCell(CircleAvatar(
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return UsuarioCreatePage(
                      usuario: p,
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
                    return UsuarioCreatePage(
                      usuario: p,
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
  int get rowCount => usuarios.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
