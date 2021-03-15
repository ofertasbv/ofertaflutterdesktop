import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixa_controller.dart';
import 'package:nosso/src/paginas/caixa/caixa_create_page.dart';
import 'package:nosso/src/paginas/caixa/caixa_table.dart';

class CaixaPage extends StatelessWidget {
  var caixaController = GetIt.I.get<CaixaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        elevation: 0,
        title: Text("Caixas"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (caixaController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (caixaController.caixas == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                child: Text(
                  (caixaController.caixas.length ?? 0).toString(),
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
                caixaController.getAll();
              },
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: CaixaTable(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CaixaCreatePage();
              },
            ),
          );
        },
      ),
    );
  }
}
