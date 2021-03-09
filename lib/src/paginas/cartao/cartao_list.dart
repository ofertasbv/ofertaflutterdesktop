import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/cartao_controller.dart';
import 'package:nosso/src/core/model/cartao.dart';
import 'package:nosso/src/paginas/cartao/cartao_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class CartaoList extends StatefulWidget {
  @override
  _CartaoListState createState() => _CartaoListState();
}

class _CartaoListState extends State<CartaoList>
    with AutomaticKeepAliveClientMixin<CartaoList> {
  var cartaoController = GetIt.I.get<CartaoController>();

  @override
  void initState() {
    cartaoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return cartaoController.getAll();
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
          List<Cartao> cartoes = cartaoController.cartoes;
          if (cartaoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (cartoes == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(cartoes),
          );
        },
      ),
    );
  }

  builderList(List<Cartao> cartoes) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: cartoes.length,
      itemBuilder: (context, index) {
        Cartao c = cartoes[index];

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
                  return CartaoCreatePage(
                    cartao: c,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  PopupMenuButton<String> buildPopupMenuButton(BuildContext context, Cartao c) {
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
                return CartaoCreatePage(
                  cartao: c,
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
