import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixafluxo_controller.dart';
import 'package:nosso/src/core/controller/caixafluxosaida_controller.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_create_page.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_list.dart';
import 'package:nosso/src/paginas/caixafluxosaida/caixafluxosaida_create_page.dart';
import 'package:nosso/src/paginas/caixafluxosaida/caixafluxosaida_list.dart';

class CaixaFluxoSaidaPage extends StatelessWidget {
  var caixafluxosaidaController = GetIt.I.get<CaixafluxosaidaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Text("Caixa despesas"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (caixafluxosaidaController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (caixafluxosaidaController.caixaSaidas == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Text(
                  (caixafluxosaidaController.caixaSaidas.length ?? 0)
                      .toString(),
                ),
              );
            },
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: Card(child: CaixaFluxoSaidaList()),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CaixaFluxoSaidaCreatePage();
              },
            ),
          );
        },
      ),
    );
  }
}
