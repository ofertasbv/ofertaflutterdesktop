import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/home/catalogo_home.dart';
import 'package:nosso/src/home/drawer_list.dart';
import 'package:nosso/src/paginas/categoria/categoria_subcategoria.dart';
import 'package:nosso/src/paginas/loja/loja_list.dart';
import 'package:nosso/src/paginas/pedidoitem/itens_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/paginas/promocao/promocao_list.dart';
import 'package:nosso/src/paginas/usuario/usuario_perfil_page.dart';
import 'package:nosso/src/util/Examples/teste_mapa.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var usuarioController = GetIt.I.get<UsuarioController>();
  var pageController = PageController();

  int elementIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: WillPopScope(
        onWillPop: onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            bottomOpacity: 0,
            titleSpacing: 50,
            title: Text("U-NOSSO"),
            actions: <Widget>[
              CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
                foregroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(Icons.location_on_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TesteMapa(
                          androidFusedLocation: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
                foregroundColor: Colors.black,
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
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.4),
                  foregroundColor: Colors.black,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 0, right: 0),
                        child: Icon(Icons.shopping_basket),
                      ),
                      Container(
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
                              (pedidoItemController.itens.length ?? 0)
                                  .toString(),
                              style: TextStyle(color: Colors.deepOrangeAccent),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
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
          ),
          body: Scrollbar(child: Center(child: lista[elementIndex])),
          // bottomNavigationBar: buildBottomNavigationBar(),

/* ======================= Menu lateral ======================= */
          drawer: DrawerList(),
/* ======================= Botão Flutuante ======================= */
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          title: Text('home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          title: Text('categorias'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_convenience_store_outlined),
          title: Text('lojas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_alert_outlined),
          title: Text('ofertas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          title: Text('conta'),
        ),
      ],
      currentIndex: elementIndex,
      onTap: changeIndex,
      elevation: 4,
    );
  }

  buildGestureDetector(BuildContext context) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 2, right: 2),
            child: Icon(Icons.shopping_basket),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 16),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.white.withOpacity(.7),
            ),
            child: Center(
              child: Text("0"),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  Future<bool> onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Deseja sair do aplicativo?'),
            content: new Text(''),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              FlatButton(
                // onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => MyApp()),
                //   );
                // },
                child: new Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }

  List lista = [
    CatalogoHome(),
    CategoriaSubCategoria(),
    LojaList(),
    PromocaoList(),
    UsuarioPerfilPage(),
  ];

  changeIndex(int index) {
    setState(() {
      elementIndex = index;
    });
  }
}
