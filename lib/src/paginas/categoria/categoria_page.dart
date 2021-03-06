import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/seguimento.dart';
import 'package:nosso/src/paginas/categoria/categoria_list.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class CategoriaPage extends StatefulWidget {
  Seguimento s;

  CategoriaPage({Key key, this.s}) : super(key: key);

  @override
  _CategoriaPageState createState() => _CategoriaPageState(seguimento: this.s);
}

class _CategoriaPageState extends State<CategoriaPage> {
  var categoriaController = GetIt.I.get<CategoriaController>();

  _CategoriaPageState({this.seguimento});

  Seguimento seguimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("todos os departamentos"),
        elevation: 0,
        titleSpacing: 0,
        actions: [
          Observer(
            builder: (context) {
              List<Categoria> categorias = categoriaController.categorias;
              if (categoriaController.error != null) {
                return Text("Não foi possível carregados dados");
              }

              if (categorias == null) {
                return CircularProgressorMini();
              }

              return CircleAvatar(
                foregroundColor: Theme.of(context).accentColor,
                child: Text(
                  (categoriaController.categorias.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 5),
          CircleAvatar(
            foregroundColor: Theme.of(context).accentColor,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                categoriaController.getAll();
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: CategoriaList(s: seguimento),
      ),
    );
  }
}
