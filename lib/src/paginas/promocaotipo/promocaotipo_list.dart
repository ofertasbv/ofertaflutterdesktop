import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/promocaotipo_controller.dart';
import 'package:nosso/src/core/model/promocaotipo.dart';
import 'package:nosso/src/paginas/promocaotipo/promocaotipo_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PromocaoTipoList extends StatefulWidget {
  @override
  _PromocaoTipoListState createState() => _PromocaoTipoListState();
}

class _PromocaoTipoListState extends State<PromocaoTipoList>
    with AutomaticKeepAliveClientMixin<PromocaoTipoList> {
  var promocaoTipoController = GetIt.I.get<PromocaoTipoController>();

  @override
  void initState() {
    promocaoTipoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return promocaoTipoController.getAll();
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
          List<PromocaoTipo> promocaoTipos =
              promocaoTipoController.promocaoTipos;
          if (promocaoTipoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (promocaoTipos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(promocaoTipos),
          );
        },
      ),
    );
  }

  builderList(List<PromocaoTipo> promocaoTipos) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: promocaoTipos.length,
      itemBuilder: (context, index) {
        PromocaoTipo c = promocaoTipos[index];

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
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 20,
                child: Text(
                  c.descricao.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text(c.descricao),
            subtitle: Text("cod: ${c.id}"),
            trailing: Container(
              height: 80,
              width: 50,
              child: buildPopupMenuButton(context, c),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoTipoCreatePage(promocaoTipo: c);
                },
              ),
            );
          },
        );
      },
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, PromocaoTipo c) {
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
                return PromocaoTipoCreatePage(promocaoTipo: c);
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
