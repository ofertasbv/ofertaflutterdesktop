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
        Container(
          height: 350,
          width: double.infinity,
          child: p.arquivos.isNotEmpty
              ? Carousel(
                  autoplay: false,
                  dotBgColor: Colors.transparent,
                  images: p.arquivos.map((a) {
                    return NetworkImage(produtoController.arquivo + a.foto);
                  }).toList())
              : Image.network(
                  produtoController.arquivo + p.foto,
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          child: ListTile(
            title: Text(p.nome),
            subtitle: Text("Código. ${p.id}"),
            trailing: CircleAvatar(
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
                    favoritar(favorito);
                    print("Favoritar: ${p.nome}");
                  });

                  if (usuarioController.usuarioSelecionado.pessoa == null) {
                    showToast("faça login para favoritar");
                  } else {
                    if (favorito.id == null) {
                      favorito.produto = p;
                      favorito.status = isFavorito;
                      // favorito.cliente =
                      //     usuarioController.usuarioSelecionado.pessoa;
                      print(
                          "Cliente: ${usuarioController.usuarioSelecionado.pessoa.nome}");
                      // favoritoController.create(favorito);
                      print("Adicionar: ${p.nome}");
                    } else {
                      favorito.produto = p;
                      favorito.status = isFavorito;
                      // favorito.cliente =
                      //     usuarioController.usuarioSelecionado.pessoa;
                      print(
                          "Cliente: ${usuarioController.usuarioSelecionado.pessoa.id}");
                      // favoritoController.update(favorito.id, favorito);
                      print("Adicionar: ${p.nome}");
                      showToast("alterando favoritos");
                    }
                  }
                },
              ),
            ),
          ),
        ),
        Divider(),
        Container(
          child: Column(
            children: [
              Container(
                child: ListTile(
                  title: Text("Departamento"),
                  subtitle: Text("${p.subCategoria.nome}"),
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
