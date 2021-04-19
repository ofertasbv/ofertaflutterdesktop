import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
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

  ProdutoFilter filter = ProdutoFilter();
  int size = 0;
  int page = 0;

  @override
  void initState() {
    if (filter == null) {
      produtoController.getAll();
    } else {
      produtoController.getFilter(filter);
    }
    super.initState();
  }

  Future<void> onRefresh() {
    return produtoController.getFilter(filter);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 0),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: builderConteudoList(),
            ),
          ),
        ],
      ),
    );
  }

  builderConteudoList() {
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

          if (produtos.length == 0) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Icon(
                      Icons.mood_outlined,
                      size: 100,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    "Ops! sem produtos",
                  ),
                ],
              ),
            );
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
    return Container(
      padding: EdgeInsets.only(top: 0, bottom: 0),
      child: Container(
        child: GridView.builder(
          padding: EdgeInsets.only(top: 10, bottom: 20, left: 0, right: 0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: MediaQuery.of(context).size.aspectRatio * 0.28,
          ),
          itemCount: produtos.length,
          itemBuilder: (context, index) {
            Produto p = produtos[index];
            return GestureDetector(
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(0),
                ),
                duration: Duration(seconds: 2),
                curve: Curves.bounceIn,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        p.foto != null
                            ? Container(
                                color: Colors.grey[300],
                                child: Image.network(
                                  produtoController.arquivo + p.foto,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 350,
                                ),
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: Image.asset(
                                  ConstantApi.urlLogo,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 350,
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
                                icon: (this.isFavorito == false
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
                          height: 60,
                          child: ListTile(
                            title: Text("${p.nome}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Container(
                          height: 70,
                          child: ListTile(
                            title: Text(
                              "R\$ ${formatMoeda.format(p.estoque.valorUnitario)}",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationStyle: TextDecorationStyle.dashed,
                              ),
                            ),
                            subtitle: Text(
                              "R\$ ${formatMoeda.format(p.estoque.valorUnitario - ((p.estoque.valorUnitario * p.promocao.desconto) / 100))}",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Chip(
                              backgroundColor: Theme.of(context).accentColor,
                              label: Text(
                                "${formatMoeda.format(p.promocao.desconto)} OFF",
                                style: TextStyle(
                                  color: Colors.grey[100],
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
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
