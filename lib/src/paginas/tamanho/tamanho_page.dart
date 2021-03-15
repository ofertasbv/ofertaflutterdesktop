import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/tamanho_controller.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_create_page.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_list.dart';

class TamanhoPage extends StatelessWidget {
  var tamanhoController = GetIt.I.get<TamanhoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        title: Text("Tamanhos"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (tamanhoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (tamanhoController.tamanhos == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (tamanhoController.tamanhos.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: TamanhoList(),
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
                  builder: (context) {
                    return TamanhoCreatePage();
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
