import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/paginas/pedido/pedido_create_page.dart';
import 'package:nosso/src/paginas/pedido/pedido_list.dart';
import 'package:nosso/src/paginas/pedido/pedido_table.dart';

class PedidoPage extends StatelessWidget {
  var pedidoController = GetIt.I.get<PedidoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        title: Text("Pedidos"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (pedidoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (pedidoController.pedidos == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (pedidoController.pedidos.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: PedidoTable(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 8,
            height: 8,
          ),
          FloatingActionButton(
            elevation: 10,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PedidoCreatePage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
