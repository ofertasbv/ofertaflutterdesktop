import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/promocaotipo_controller.dart';
import 'package:nosso/src/paginas/promocaotipo/promocaotipo_create_page.dart';
import 'package:nosso/src/paginas/promocaotipo/promocaotipo_table.dart';

class PromocaoTipoPage extends StatelessWidget {
  var promocaoTipoController = GetIt.I.get<PromocaoTipoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        title: Text("Tipos promoções"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (promocaoTipoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (promocaoTipoController.promocaoTipos == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Text(
                  (promocaoTipoController.promocaoTipos.length ?? 0).toString(),
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
                promocaoTipoController.getAll();
              },
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Card(child: PromocaoTipoTable()),
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
                return PromocaoTipoCreatePage();
              },
            ),
          );
        },
      ),
    );
  }
}
