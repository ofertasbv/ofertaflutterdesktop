import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/paginas/categoria/categoria_subcategoria.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_produto.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class CategoriaListHome extends StatefulWidget {
  @override
  _CategoriaListHomeState createState() => _CategoriaListHomeState();
}

class _CategoriaListHomeState extends State<CategoriaListHome>
    with AutomaticKeepAliveClientMixin<CategoriaListHome> {
  var categoriaController = GetIt.I.get<CategoriaController>();

  @override
  void initState() {
    categoriaController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return categoriaController.getAll();
  }

  showDialogAlert(BuildContext context, Categoria p) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Categoria'),
          content: Text(p.nome),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('EDITAR'),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return builderConteudoList();
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Categoria> categorias = categoriaController.categorias;
          if (categoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (categorias == null) {
            return CircularProgressorMini();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(categorias),
          );
        },
      ),
    );
  }

  ListView builderList(List<Categoria> categorias) {
    double containerWidth = 100;
    double containerHeight = 15;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        Categoria c = categorias[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey[100], width: 1),
              ),
              child: AnimatedContainer(
                width: 90,
                height: 150,
                alignment: Alignment.center,
                duration: Duration(seconds: 1),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[100].withOpacity(0.1),
                      Colors.grey[300].withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor],
                        ),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "${categoriaController.arquivo + c.foto}",
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      height: 40,
                      width: containerWidth,
                      child: Text(
                        c.nome.toLowerCase(),
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SubCategoriaProduto(c: c);
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
