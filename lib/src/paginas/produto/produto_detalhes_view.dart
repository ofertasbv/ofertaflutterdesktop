import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/favorito_controller.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/core/model/favorito.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProdutoDetalhesView extends StatefulWidget {
  Produto p;

  ProdutoDetalhesView(this.p);

  @override
  _ProdutoDetalhesViewState createState() => _ProdutoDetalhesViewState();
}

class _ProdutoDetalhesViewState extends State<ProdutoDetalhesView>
    with SingleTickerProviderStateMixin {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var produtoController = GetIt.I.get<ProdutoController>();
  var favoritoController = GetIt.I.get<FavoritoController>();
  var usuarioController = GetIt.I.get<UsuarioController>();

  AnimationController animationController;
  Animation<double> animation;
  static final _scaleTween = Tween<double>(begin: 1.0, end: 1.5);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isFavorito = false;

  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  Produto produto;
  Favorito favorito;

  @override
  void initState() {
    if (produto == null) {
      produto = Produto();
      favorito = Favorito();
    }
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.bounceInOut,
    );

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    produto = widget.p;
    return buildContainer(produto);
  }

  favoritar(Favorito p) {
    if (this.isFavorito == false) {
      this.isFavorito = !this.isFavorito;
      print("Teste 1: ${this.isFavorito}");
      showToast("adicionado aos favoritos");
    } else {
      this.isFavorito = !this.isFavorito;
      print("Teste 2: ${this.isFavorito}");
      showToast("removendo aos favoritos");
    }
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

  showToast(String cardTitle) {
    Fluttertoast.showToast(
      msg: "$cardTitle",
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 20,
      fontSize: 16.0,
    );
  }

  buildContainer(Produto p) {
    return ListView(
      children: <Widget>[
        // Container(
        //   height: 350,
        //   width: double.infinity,
        //   child: p.arquivos.isNotEmpty
        //       ? Carousel(
        //           autoplay: false,
        //           dotBgColor: Colors.transparent,
        //           images: p.arquivos.map((a) {
        //             return NetworkImage(produtoController.arquivo + a.foto);
        //           }).toList())
        //       : p.foto != null
        //           ? Image.network(
        //               produtoController.arquivo + p.foto,
        //               fit: BoxFit.cover,
        //             )
        //           : Image.asset(ConstantApi.urlLogo),
        // ),
        Container(
          color: Colors.grey[200],
          height: 400,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 400,
                height: 150,
                color: Colors.grey,
                padding: EdgeInsets.all(0),
                child: p.foto != null
                    ? Container(
                        width: 400,
                        height: 150,
                        color: Colors.grey[400],
                        child: Image.network(
                          "${produtoController.arquivo + p.foto}",
                          width: 400,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: 400,
                        height: 150,
                        color: Colors.grey[600],
                        child: Image.asset(
                          ConstantApi.urlLogo,
                          width: 200,
                          height: 150,
                        ),
                      ),
              ),
              Container(
                width: 500,
                height: 150,
                color: Colors.grey[200],
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ListTile(
                        title: Text(
                          p.nome,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${p.loja.nome}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: ListTile(
                        title: Text(
                          p.nome,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "${p.loja.nome}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 400,
                height: 150,
                color: Colors.grey[300],
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Chip(
                      backgroundColor: Theme.of(context).accentColor,
                      label: Text(
                        "R\$ ${formatMoeda.format(p.estoque.valorUnitario)}",
                        style: TextStyle(
                          color: Colors.grey[100],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.dashed,
                        ),
                      ),
                    ),
                    Text(
                      "R\$ ${formatMoeda.format(p.estoque.valorVenda)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${p.promocao.nome}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          child: Column(
            children: [
              Container(
                child: ListTile(
                  title: Text(
                    "Departamento",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${p.subCategoria.nome}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: p.status == true
                      ? Text(
                          "produto disponivel",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "produto indisponivel",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              Container(
                child: ListTile(
                  title: Text(
                    "De ${formatMoeda.format(p.estoque.valorUnitario)}",
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough,
                      decorationStyle: TextDecorationStyle.dashed,
                    ),
                  ),
                  subtitle: Text(
                    "R\$ ${formatMoeda.format(p.estoque.valorUnitario - ((p.estoque.valorUnitario * p.promocao.desconto) / 100))} a vista",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Chip(
                    label: Text(
                      "${formatMoeda.format(p.promocao.desconto)} OFF",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
