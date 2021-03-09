import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/favorito_controller.dart';
import 'package:nosso/src/paginas/favorito/favorito_list.dart';
import 'package:nosso/src/paginas/marca/marca_create_page.dart';
import 'package:nosso/src/paginas/marca/marca_list.dart';

class FavoritoPage extends StatelessWidget {
  var favoritoController = GetIt.I.get<FavoritoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (favoritoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (favoritoController.favoritos == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (favoritoController.favoritos.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: FavoritoList(),
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
                    return MarcaCreatePage();
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
