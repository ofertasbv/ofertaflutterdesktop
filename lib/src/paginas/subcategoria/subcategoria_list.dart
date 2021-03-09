import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class SubCategoriaList extends StatefulWidget {
  @override
  _SubCategoriaListState createState() => _SubCategoriaListState();
}

class _SubCategoriaListState extends State<SubCategoriaList>
    with AutomaticKeepAliveClientMixin<SubCategoriaList> {
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();

  @override
  void initState() {
    subCategoriaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return subCategoriaController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoList();
  }

  builderConteudoList() {
    return Observer(
      builder: (context) {
        List<SubCategoria> categorias = subCategoriaController.subCategorias;
        if (subCategoriaController.error != null) {
          return Text("Não foi possível carregados dados");
        }

        if (categorias == null) {
          return CircularProgressor();
        }

        return RefreshIndicator(
          onRefresh: onRefresh,
          child: builderList(categorias),
        );
      },
    );
  }

  builderList(List<SubCategoria> categorias) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        SubCategoria c = categorias[index];

        return GestureDetector(
          child: ListTile(
            isThreeLine: true,
            leading: Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 20,
                child: Text(
                  c.nome.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text(c.nome),
            subtitle: Text("${c.categoria.nome}"),
            trailing: Container(
              height: 80,
              width: 50,
              child: buildPopupMenuButton(context, c),
            ),
          ),
          onTap: () {},
        );
      },
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, SubCategoria c) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_vert),
      onSelected: (valor) {
        if (valor == "novo") {
          print("novo");
        }
        if (valor == "editar") {
          print("editar");
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return SubCategoriaCreatePage(
                  subCategoria: c,
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
            title: Text('Delete'),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
