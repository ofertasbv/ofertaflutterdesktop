import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/home/cartao_credito_home.dart';
import 'package:nosso/src/home/categoria_list_home.dart';
import 'package:nosso/src/home/club_vantagens_home.dart';
import 'package:nosso/src/home/drawer_list.dart';
import 'package:nosso/src/home/logo.dart';
import 'package:nosso/src/home/produto_list_home.dart';
import 'package:nosso/src/home/promocao_list_home.dart';
import 'package:nosso/src/paginas/categoria/categoria_page_list.dart';
import 'package:nosso/src/paginas/pedidoitem/pedito_itens_page.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/paginas/promocao/promocao_banner.dart';
import 'package:nosso/src/paginas/promocao/promocao_page_list.dart';
import 'package:nosso/src/paginas/usuario/usuario_login_page.dart';
import 'package:nosso/src/util/Examples/teste_mapa.dart';
import 'package:nosso/src/util/config/config_page.dart';
// import 'package:gscarousel/gscarousel.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pedidoItemController = GetIt.I.get<PedidoItemController>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          width: 700,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Logo(),
              Container(
                child: Container(
                  height: 70,
                  width: 500,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: TextFormField(
                    // controller: nomeController,
                    decoration: InputDecoration(
                      hintText: "busca por produtos",
                      fillColor: Colors.deepPurpleAccent,
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // onChanged: filterByNome,
                  ),
                ),
              )
            ],
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.location_on_outlined,
                color: Colors.grey[200],
              ),
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
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.search_outlined,
                color: Colors.grey[200],
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ProdutoSearchDelegate(),
                );
              },
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              foregroundColor: Theme.of(context).primaryColor,
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
                        color: Colors.white.withOpacity(0.7),
                      ),
                      child: Center(
                        child: Text(
                          (pedidoItemController.itens.length ?? 0).toString(),
                          style: TextStyle(color: Colors.black87),
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
                  builder: (context) => PedidoItensListPage(),
                ),
              );
            },
          ),
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.dashboard,
                color: Colors.grey[200],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ConfigPage();
                  }),
                );
              },
            ),
          ),
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.person_outline,
                color: Colors.grey[200],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return UsuarioLoginPage();
                  }),
                );
              },
            ),
          ),
          SizedBox(width: 60),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          if (constraint.maxWidth < 650) {
            return Container(
              color: Colors.transparent,
              child: buildColun(context),
            );
          }
          if (constraint.minWidth >= 650 && constraint.maxWidth <= 900) {
            return Container(
              color: Colors.transparent,
              child: buildColun(context),
            );
          } else {
            return Container(
              color: Colors.transparent,
              child: buildRow(context),
            );
          }
        },
      ),
      drawer: DrawerList(),
    );
  }

  buildColun(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.deepOrangeAccent,
            child: Text("TESTE1"),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.redAccent,
            child: Text("TESTE2"),
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.green,
            child: Text("TESTE3"),
          ),
        ),
      ],
    );
  }

  buildRow(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          Container(
            height: 300,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 65, right: 65),
            child: Container(
              height: 300,
              color: Colors.grey[400],
              child: PromocaoBanner(),
            ),
          ),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Container(
              height: 80,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    padding: EdgeInsets.only(top: 20),
                    child: buildContainerCategoriaMenu(context),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 350,
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Container(
              height: 350,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: 350,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: CategoriaListHome(),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            padding: EdgeInsets.only(left: 65, right: 65),
            child: CartaoCreditoHome(),
          ),
          SizedBox(height: 20),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Container(
              height: 100,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(top: 20),
                    child: buildContainerPromocaoMenu(context),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Container(
              height: 550,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: 500,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: PromocaoListHome(),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            padding: EdgeInsets.only(left: 65, right: 65),
            child: ClubVantagensHome(),
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 1,
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Container(
              height: 100,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(left: 0, right: 0, top: 20),
                    child: buildContainerProdutoMenu(context),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Container(
              height: 200,
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: ProdutoListHome(),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 100,
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 65, right: 65),
            child: Container(
              height: 100,
              color: Colors.grey[200],
              padding: EdgeInsets.all(10),
              child: ListTile(
                leading: Logo(),
                title: Text(
                  "BOOKOFERTAS - Marketplace",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Todos os direitos reservados",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text("Avenida Brasil - Novo Repartimento - PÁ"),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Scrollbar buildScrollbar(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          Container(
            height: 300,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 50, right: 50),
            child: Container(
              height: 300,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 20),
          buildContainerCategoriaMenu(context),
          Container(
            height: 300,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 50, right: 50),
            child: CategoriaListHome(),
          ),
          SizedBox(height: 20),
          buildContainerPromocaoMenu(context),
          Container(
            height: 500,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 50, right: 50),
            child: PromocaoListHome(),
          ),
          SizedBox(height: 20),
          buildContainerProdutoMenu(context),
          Container(
            height: 200,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 50, right: 50),
            child: ProdutoListHome(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  buildContainerPromocaoMenu(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(0),
      child: ListTile(
        leading: Text(
          "Promoçõe em destaque",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(
          "veja todas promoções",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: RaisedButton(
          padding: EdgeInsets.only(left: 50, right: 50),
          color: Theme.of(context).accentColor,
          child: Text(
            "VER MAIS",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoPageList();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  buildContainerProdutoMenu(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(0),
      child: ListTile(
        leading: Text(
          "Produtos em destaque",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(
          "veja todos produtos",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: RaisedButton(
          padding: EdgeInsets.only(left: 50, right: 50),
          color: Theme.of(context).accentColor,
          child: Text(
            "VER MAIS",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoPage();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  buildContainerCategoriaMenu(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(0),
      child: ListTile(
        leading: Text(
          "Departamentos em destaque",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(
          "veja todas departamentos",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: RaisedButton(
          padding: EdgeInsets.only(left: 50, right: 50),
          color: Theme.of(context).accentColor,
          child: Text(
            "VER MAIS",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoriaPageList();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
