import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/tamanho_controller.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_create_page.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_table.dart';

class TamanhoPage extends StatelessWidget {
  var tamanhoController = GetIt.I.get<TamanhoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
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

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Text(
                  (tamanhoController.tamanhos.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                tamanhoController.getAll();
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: Card(child: TamanhoTable()),
      ),
      floatingActionButton: FloatingActionButton(
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
      ),
    );
  }
}
