import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pagamento_controller.dart';
import 'package:nosso/src/core/model/pagamento.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PagamentoList extends StatefulWidget {
  @override
  _PagamentoListState createState() => _PagamentoListState();
}

class _PagamentoListState extends State<PagamentoList>
    with AutomaticKeepAliveClientMixin<PagamentoList> {
  var pagamentoController = GetIt.I.get<PagamentoController>();

  @override
  void initState() {
    pagamentoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return pagamentoController.getAll();
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
          List<Pagamento> pagamentos = pagamentoController.pagamentos;
          if (pagamentoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (pagamentos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(pagamentos),
          );
        },
      ),
    );
  }

  builderList(List<Pagamento> pagamentos) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: pagamentos.length,
      itemBuilder: (context, index) {
        Pagamento c = pagamentos[index];

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
                  "${c.id}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text("${c.id}"),
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
                  return PagamentoCreatePage(
                    pagamento: c,
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
      BuildContext context, Pagamento c) {
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
                return PagamentoCreatePage(
                  pagamento: c,
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
