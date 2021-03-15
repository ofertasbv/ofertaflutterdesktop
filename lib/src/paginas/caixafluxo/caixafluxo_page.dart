import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixafluxo_controller.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_create_page.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_list.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_table.dart';

class CaixaFluxoPage extends StatelessWidget {
  var caixafluxoController = GetIt.I.get<CaixafluxoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        title: Text("Caixa fluxos"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (caixafluxoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (caixafluxoController.caixaFluxos == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                child: Text(
                  (caixafluxoController.caixaFluxos.length ?? 0).toString(),
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
                caixafluxoController.getAll();
              },
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: CaixaFluxoTable(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CaixaFluxoCreatePage();
              },
            ),
          );
        },
      ),
    );
  }
}
