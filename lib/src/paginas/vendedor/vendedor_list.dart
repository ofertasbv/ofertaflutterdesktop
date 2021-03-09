import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/core/model/vendedor.dart';
import 'package:nosso/src/paginas/vendedor/vendedor_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class VendedorList extends StatefulWidget {
  @override
  _VendedorListState createState() => _VendedorListState();
}

class _VendedorListState extends State<VendedorList>
    with AutomaticKeepAliveClientMixin<VendedorList> {
  var vendedorController = GetIt.I.get<VendedorController>();

  @override
  void initState() {
    vendedorController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return vendedorController.getAll();
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
          List<Vendedor> vendedores = vendedorController.vendedores;
          if (vendedorController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (vendedores == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(vendedores),
          );
        },
      ),
    );
  }

  ListView builderList(List<Vendedor> vendedores) {
    double containerWidth = 160;
    double containerHeight = 30;

    return ListView.builder(
      itemCount: vendedores.length,
      itemBuilder: (context, index) {
        Vendedor p = vendedores[index];

        return GestureDetector(
          child: ListTile(
            isThreeLine: true,
            leading: Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor
                  ],
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
              child: p.foto == null
                  ? CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 20,
                      child: Icon(Icons.photo))
                  : CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "${vendedorController.arquivo + p.foto}",
                      ),
                    ),
            ),
            title: Text(p.nome),
            subtitle: Text("${p.telefone}"),
            trailing: Container(
              height: 80,
              width: 50,
              child: buildPopupMenuButton(context, p),
            ),
          ),
          onTap: () {},
        );
      },
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, Vendedor p) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_vert),
      onSelected: (valor) {
        if (valor == "novo") {
          print("novo");
        }

        if (valor == "editar") {
          print("editar");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return VendedorCreatePage(
                  vendedor: p,
                );
              },
            ),
          );
        }
        if (valor == "delete") {
          print("delete");
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'novo',
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text('novo'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'editar',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('editar'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('delete'),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
