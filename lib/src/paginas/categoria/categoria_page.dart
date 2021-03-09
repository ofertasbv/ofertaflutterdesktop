import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/paginas/categoria/categoria_create_page.dart';
import 'package:nosso/src/paginas/categoria/categoria_list.dart';

class CategoriaPage extends StatelessWidget {
  var categoriaController = GetIt.I.get<CategoriaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (categoriaController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (categoriaController.categorias == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (categoriaController.categorias.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: CategoriaList(),
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
                    return CategoriaCreatePage();
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
