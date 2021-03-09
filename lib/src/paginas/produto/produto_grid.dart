import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/favorito_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/favorito.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/produto/produto_create_page.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_tab.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class ProdutoGrid extends StatefulWidget {
  ProdutoFilter filter;

  ProdutoGrid({Key key, this.filter}) : super(key: key);

  @override
  _ProdutoGridState createState() => _ProdutoGridState(filter: this.filter);
}

class _ProdutoGridState extends State<ProdutoGrid>
    with AutomaticKeepAliveClientMixin<ProdutoGrid> {
  _ProdutoGridState({this.filter});

  var produtoController = GetIt.I.get<ProdutoController>();
  var favoritoController = GetIt.I.get<FavoritoController>();

  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Favorito favorito;
  Produto produto;
  bool isFavorito = false;

  ProdutoFilter filter;
  int size = 0;
  int page = 0;

  @override
  void initState() {
    if (favorito == null) {
      favorito = Favorito();
      produto = Produto();
    }
    produtoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return produtoController.getAll();
  }

  favoritar() {
    this.favorito.status = !this.favorito.status;
    print("${this.favorito.status}");
  }

  showSnackbar(BuildContext context, String content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      ),
    );
  }

  showDialogAlert(BuildContext context, Produto p) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('INFORMAÇÃOES'),
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProdutoCreatePage(
                        produto: p,
                      );
                    },
                  ),
                );
              },
            ),
            FlatButton(
              child: const Text('VER DETALHES'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProdutoDetalhesTab(p);
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Produto> produtos = produtoController.produtos;
          if (produtoController.error != null) {
            return Text("Não foi possível buscar produtos");
          }

          if (produtos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderGrid(produtos),
          );
        },
      ),
    );
  }

  builderGrid(List<Produto> produtos) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: MediaQuery.of(context).size.aspectRatio * 1.2,
      ),
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];
        return GestureDetector(
          child: AnimatedContainer(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[100].withOpacity(0.1),
                  Colors.grey[300].withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            duration: Duration(seconds: 2),
            curve: Curves.bounceIn,
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        produtoController.arquivo + p.foto,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, right: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.redAccent,
                          radius: 15,
                          child: IconButton(
                            splashColor: Colors.black,
                            icon: (this.favorito.status == false
                                ? Icon(
                                    Icons.favorite_border,
                                    color: Colors.redAccent,
                                    size: 15,
                                  )
                                : Icon(
                                    Icons.favorite_outlined,
                                    color: Colors.redAccent,
                                    size: 15,
                                  )),
                            onPressed: () {
                              setState(() {
                                print("Favoritar: ${p.nome}");
                                // favoritar();
                              });

                              // if (favorito.id == null) {
                              //   favorito.produto = p;
                              //   favorito.status = isFavorito;
                              //   favoritoController.create(favorito);
                              //   print("Adicionar: ${p.nome}");
                              // } else {
                              //   favorito.produto = p;
                              //   favorito.status = isFavorito;
                              //   favoritoController.update(
                              //       favorito.id, favorito);
                              //   print("Alterar: ${p.nome}");
                              //   showSnackbar(context, "favorito");
                              // }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 30,
                      padding: EdgeInsets.all(6),
                      child: Text("${p.nome}", overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      height: 60,
                      child: ListTile(
                        title: Text(
                          "${formatMoeda.format(p.estoque.valorUnitario)}",
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            decorationStyle: TextDecorationStyle.dashed,
                          ),
                        ),
                        subtitle: Text(
                          "R\$ ${formatMoeda.format(p.estoque.valorUnitario - ((p.estoque.valorUnitario * p.promocao.desconto) / 100))}",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Chip(
                          label: Text(
                            "${formatMoeda.format(p.promocao.desconto)} OFF",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoDetalhesTab(p);
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
