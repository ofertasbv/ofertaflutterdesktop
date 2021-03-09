import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/arquivo_controller.dart';
import 'package:nosso/src/core/model/arquivo.dart';
import 'package:nosso/src/paginas/arquivo/arquivo_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class ArquivoList extends StatefulWidget {
  @override
  _ArquivoListState createState() => _ArquivoListState();
}

class _ArquivoListState extends State<ArquivoList>
    with AutomaticKeepAliveClientMixin<ArquivoList> {
  var arquivoController = GetIt.I.get<ArquivoController>();

  @override
  void initState() {
    arquivoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return arquivoController.getAll();
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
          List<Arquivo> arquivos = arquivoController.arquivos;
          if (arquivoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (arquivos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(arquivos),
          );
        },
      ),
    );
  }

  builderList(List<Arquivo> arquivos) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: arquivos.length,
      itemBuilder: (context, index) {
        Arquivo c = arquivos[index];

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
                backgroundImage: NetworkImage(
                  "${arquivoController.arquivoFoto + c.foto}",
                ),
              ),
            ),
            title: Text(c.foto),
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
                  return ArquivoCreatePage(
                    arquivo: c,
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
      BuildContext context, Arquivo c) {
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
                return ArquivoCreatePage(
                  arquivo: c,
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
