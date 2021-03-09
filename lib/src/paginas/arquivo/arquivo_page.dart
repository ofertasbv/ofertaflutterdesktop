import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/arquivo_controller.dart';
import 'package:nosso/src/paginas/arquivo/arquivo_create_page.dart';
import 'package:nosso/src/paginas/arquivo/arquivo_list.dart';

class ArquivoPage extends StatelessWidget {
  var arquivoController = GetIt.I.get<ArquivoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arquivos"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (arquivoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (arquivoController.arquivos == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (arquivoController.arquivos.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ArquivoList(),
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
                  builder: (context) {
                    return ArquivoCreatePage();
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
