import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/pedidoitem/itens_page.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_info.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_view.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/util/snackbar/snackbar_global.dart';

class ProdutoDetalhesTab extends StatefulWidget {
  Produto p;

  ProdutoDetalhesTab(this.p);

  @override
  _ProdutoDetalhesTabState createState() => _ProdutoDetalhesTabState();
}

class _ProdutoDetalhesTabState extends State<ProdutoDetalhesTab>
    with SingleTickerProviderStateMixin {
  var produtoController = GetIt.I.get<ProdutoController>();
  var pedidoItemController = GetIt.I.get<PedidoItemController>();

  AnimationController animationController;
  Animation<double> animation;
  static final scaleTween = Tween<double>(begin: 1.0, end: 1.5);

  bool isFavorito = false;

  Produto p;
  var text = "";

  @override
  void initState() {
    if (p == null) {
      p = Produto();
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

  showSnackbar(BuildContext context, String texto) {
    final snackbar = SnackBar(content: Text(texto));
    GlobalScaffold.instance.showSnackbar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    p = widget.p;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: GlobalScaffold.instance.scaffkey,
        appBar: AppBar(
          titleSpacing: 50,
          title: p.nome == null ? Text("Detalhes do produto") : Text(p.nome),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
              foregroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ProdutoSearchDelegate(),
                  );
                },
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
                foregroundColor: Colors.white,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 0, right: 0),
                      child: Icon(Icons.shopping_basket),
                    ),
                    AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: scaleTween.evaluate(animation),
                          child: child,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 0, right: 0),
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.black, width: 1),
                          color: Colors.white.withOpacity(.7),
                        ),
                        child: Center(
                          child: Text(
                            (pedidoItemController.itens.length ?? 0).toString(),
                            style: TextStyle(color: Colors.yellow[900]),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemPage(),
                  ),
                );
              },
            ),
            SizedBox(width: 100),
          ],
          bottom: TabBar(
            indicatorPadding: EdgeInsets.only(right: 6, left: 6),
            labelPadding: EdgeInsets.only(right: 6, left: 6),
            tabs: <Widget>[
              Tab(
                child: Text("VISÃO GERAL"),
              ),
              Tab(
                child: Text("INFORMAÇÕES"),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 100, right: 100, top: 10),
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              ProdutoDetalhesView(p),
              ProdutoDetalhesInfo(p),
            ],
          ),
        ),
        bottomNavigationBar: buildBottomNavigationBar(context),
      ),
    );
  }

  buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 100, right: 100, top: 10),
      color: Colors.grey[100],
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: FlatButton.icon(
                icon: Icon(Icons.list_alt),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: Colors.blue),
                ),
                color: Colors.white,
                textColor: Colors.blue,
                padding: EdgeInsets.all(10),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProdutoTab();
                      },
                    ),
                  );
                },
                label: Text(
                  "VER MAIS".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: FlatButton.icon(
                icon: Icon(Icons.shopping_basket),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: Colors.green),
                ),
                color: Colors.white,
                textColor: Colors.green,
                padding: EdgeInsets.all(10),
                onPressed: () {
                  if (pedidoItemController
                      .isExisteItem(new PedidoItem(produto: p))) {
                    showSnackbar(context, "${p.nome} já existe");
                  } else {
                    showSnackbar(context, "${p.nome} adicionado");
                    setState(() {
                      pedidoItemController.adicionar(new PedidoItem(produto: p));
                      animationController.forward();
                    });
                  }
                },
                label: Text(
                  "LISTA DE DESEJO".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
