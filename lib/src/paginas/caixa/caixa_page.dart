import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/caixa_controller.dart';
import 'package:nosso/src/paginas/caixa/caixa_create_page.dart';
import 'package:nosso/src/paginas/caixa/caixa_list.dart';

class CaixaPage extends StatelessWidget {
  var caixaController = GetIt.I.get<CaixaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

              return Chip(
                label: Text(
                  (caixaController.caixas.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: CaixaList(),
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
