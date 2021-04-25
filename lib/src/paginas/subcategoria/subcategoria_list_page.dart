import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_create_page.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_list.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_table.dart';

class SubcategoriaListPage extends StatefulWidget {
  Categoria c;

  SubcategoriaListPage({Key key, this.c}) : super(key: key);

  @override
  _SubcategoriaListPageState createState() => _SubcategoriaListPageState(c: this.c);
}

class _SubcategoriaListPageState extends State<SubcategoriaListPage> {
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();

  Categoria c;

  _SubcategoriaListPageState({this.c});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Text("Subcategorias"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (subCategoriaController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (subCategoriaController.subCategorias == null) {
                return Center(
                  child: Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.grey[200],
                  ),
                );
              }

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Text(
                  (subCategoriaController.subCategorias.length ?? 0).toString(),
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
                color: Colors.grey[200],
              ),
              onPressed: () {
                subCategoriaController.getAll();
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Card(child: SubCategoriaList()),
      ),
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
