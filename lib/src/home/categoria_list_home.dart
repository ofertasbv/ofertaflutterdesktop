import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_produto.dart';
import 'package:nosso/src/util/load/shimmerListCategoriaHome.dart';

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
            return Text("N??o foi poss??vel carregados dados");
          }

          if (categorias == null) {
            return ShimmerListCategoriaHome();
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
    double containerWidth = 250;
    double containerHeight = 15;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        Categoria c = categorias[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: AnimatedContainer(
              width: 250,
              height: 350,
              duration: Duration(seconds: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(1),
                    color: Colors.grey[100].withOpacity(1),
                    width: double.infinity,
                    height: 200,
                    child: c.foto != null
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                            backgroundImage: NetworkImage(
                              "${categoriaController.arquivo + c.foto}",
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 50,
                          ),
                  ),
                  SizedBox(height: 0),
                  Container(
                    padding: EdgeInsets.all(0),
                    height: 80,
                    width: containerWidth,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "${c.nome}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800],
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  )
                ],
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
