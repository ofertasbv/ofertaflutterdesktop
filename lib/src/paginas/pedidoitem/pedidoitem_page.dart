import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/paginas/pdv/caixa_pdv_page.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_list.dart';

class PedidoItemPage extends StatelessWidget {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Itens pedido"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (pedidoItemController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (pedidoItemController.pedidoItens == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (pedidoItemController.pedidoItens.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: PedidoItemList(),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CaixaPDVPage();
              },
            ),
          );
        },
      ),
    );
  }
}
