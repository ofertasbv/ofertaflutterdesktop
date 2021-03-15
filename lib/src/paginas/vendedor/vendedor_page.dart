import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/paginas/vendedor/vendedor_create_page.dart';
import 'package:nosso/src/paginas/vendedor/vendedor_table.dart';

class VendedorPage extends StatelessWidget {
  var vendedorController = GetIt.I.get<VendedorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        elevation: 0,
        title: Text("Vendedores"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (vendedorController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (vendedorController.vendedores == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (vendedorController.vendedores.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: VendedorTable(),
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
                  builder: (context) => VendedorCreatePage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
