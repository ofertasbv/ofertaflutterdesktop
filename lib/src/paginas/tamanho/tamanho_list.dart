import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/tamanho_controller.dart';
import 'package:nosso/src/core/model/tamanho.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class TamanhoList extends StatefulWidget {
  @override
  _TamanhoListState createState() => _TamanhoListState();
}

class _TamanhoListState extends State<TamanhoList>
    with AutomaticKeepAliveClientMixin<TamanhoList> {
  var tamanhoController = GetIt.I.get<TamanhoController>();

  @override
  void initState() {
    tamanhoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return tamanhoController.getAll();
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
          List<Tamanho> tamanhos = tamanhoController.tamanhos;
          if (tamanhoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (tamanhos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(tamanhos),
          );
        },
      ),
    );
  }

  builderList(List<Tamanho> tamanhos) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: tamanhos.length,
      itemBuilder: (context, index) {
        Tamanho c = tamanhos[index];

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
                  return TamanhoCreatePage(
                    tamanho: c,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(
      BuildContext context, Tamanho c) {
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
                return TamanhoCreatePage(
                  tamanho: c,
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
