import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/cartao_controller.dart';
import 'package:nosso/src/paginas/cartao/cartao_create_page.dart';
import 'package:nosso/src/paginas/cartao/cartao_list.dart';

class CartaoPage extends StatelessWidget {
  var cartaoController = GetIt.I.get<CartaoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Text("Cartões"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (cartaoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (cartaoController.cartoes == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Text(
                  (cartaoController.cartoes.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: Card(child: CartaoList()),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CartaoCreatePage();
              },
            ),
          );
        },
      ),
    );
  }
}
