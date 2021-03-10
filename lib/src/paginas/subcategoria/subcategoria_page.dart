import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_create_page.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_list.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_table.dart';

class SubcategoriaPage extends StatefulWidget {
  Categoria c;

  SubcategoriaPage({Key key, this.c}) : super(key: key);

  @override
  _SubcategoriaPageState createState() => _SubcategoriaPageState(c: this.c);
}

class _SubcategoriaPageState extends State<SubcategoriaPage> {
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();

  Categoria c;

  _SubcategoriaPageState({this.c});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subcategorias"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (subCategoriaController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (subCategoriaController.subCategorias == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (subCategoriaController.subCategorias.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SubCategoriaTable(),
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
                MaterialPageRoute(builder: (context) {
                  return SubCategoriaCreatePage();
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
