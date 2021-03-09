import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixa_controller.dart';
import 'package:nosso/src/core/model/caixa.dart';
import 'package:nosso/src/paginas/caixa/caixa_create_page.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_create_page.dart';
import 'package:nosso/src/paginas/pdv/caixa_pdv_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class CaixaList extends StatefulWidget {
  @override
  _CaixaListState createState() => _CaixaListState();
}

class _CaixaListState extends State<CaixaList>
    with AutomaticKeepAliveClientMixin<CaixaList> {
  var caixaController = GetIt.I.get<CaixaController>();

  @override
  void initState() {
    caixaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return caixaController.getAll();
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
          List<Caixa> caixas = caixaController.caixas;
          if (caixaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (caixas == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(caixas),
          );
        },
      ),
    );
  }

  builderList(List<Caixa> caixas) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: caixas.length,
      itemBuilder: (context, index) {
        Caixa c = caixas[index];

        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Container(
              margin: EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey[200],
                    Colors.grey[300],
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 21),
                    blurRadius: 54,
                    color: Colors.black.withOpacity(0.05),
                  )
                ],
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(10),
              ),
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
                    backgroundColor: c.caixaStatus == "ABERTO"
                        ? Colors.green[600]
                        : Colors.red[600],
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
                subtitle: Text(c.caixaStatus),
                trailing: Container(
                  height: 80,
                  width: 50,
                  child: buildPopupMenuButton(context, c),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(BuildContext context, Caixa c) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      icon: Icon(Icons.more_vert),
      onSelected: (valor) {
        if (valor == "fluxo") {
          print("fluxo");
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return CaixaFluxoCreatePage(caixa: c);
              },
            ),
          );
        }
        if (valor == "pdv") {
          print("pdv");
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return CaixaPDVPage(caixa: c);
              },
            ),
          );
        }
        if (valor == "editar") {
          print("editar");
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return CaixaCreatePage(caixa: c);
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
          value: 'fluxo',
          child: ListTile(
            leading: Icon(Icons.computer_outlined),
            title: Text('fluxo'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'pdv',
          child: ListTile(
            leading: Icon(Icons.shop_outlined),
            title: Text('pdv'),
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
