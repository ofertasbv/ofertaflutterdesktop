import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/cliente_controller.dart';
import 'package:nosso/src/paginas/cliente/cliente_create_page.dart';
import 'package:nosso/src/paginas/cliente/cliente_table.dart';

class ClientePage extends StatelessWidget {
  var clienteController = GetIt.I.get<ClienteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: Text("Clientes"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (clienteController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (clienteController.clientes == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                child: Text(
                  (clienteController.clientes.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                clienteController.getAll();
              },
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: Card(child: ClienteTable()),
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
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClienteCreatePage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
