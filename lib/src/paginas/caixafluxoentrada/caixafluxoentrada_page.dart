import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixafluxoentrada_controller.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_create_page.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_list.dart';
import 'package:nosso/src/paginas/caixafluxoentrada/caixafluxoentrada_create_page.dart';
import 'package:nosso/src/paginas/caixafluxoentrada/caixafluxoentrada_list.dart';

class CaixaFluxoEntradaPage extends StatelessWidget {
  var caixafluxoentradaController = GetIt.I.get<CaixafluxoentradaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Caixa receitas"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (caixafluxoentradaController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (caixafluxoentradaController.caixaEntradas == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (caixafluxoentradaController.caixaEntradas.length ?? 0)
                      .toString(),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Card(child: CaixaFluxoEntradaList()),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CaixaFluxoEntradaCreatePage();
              },
            ),
          );
        },
      ),
    );
  }
}
