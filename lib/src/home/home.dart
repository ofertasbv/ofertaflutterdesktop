import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/home/categoria_list_home.dart';
import 'package:nosso/src/home/produto_list_home.dart';
import 'package:nosso/src/home/promocao_list_home.dart';
import 'package:nosso/src/paginas/categoria/categoria_page_list.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/paginas/promocao/promocao_page_list.dart';
import 'package:nosso/src/util/config/config_page.dart';
// import 'package:gscarousel/gscarousel.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: buildContainerHeader(context),
      ),
      body: buildScrollbar(context),
    );
  }

  Container buildContainerHeader(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.transparent,
      width: double.infinity,
      child: Container(
        color: Colors.transparent,
        width: 800,
        padding: EdgeInsets.only(top: 0, left: 0, right: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 70,
              width: 300,
              color: Colors.transparent,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Icon(
                    Icons.shopping_basket,
                    size: 25,
                    color: Colors.grey[100],
                  ),
                ),
                title: Text(
                  "BOOK OFERTAS",
                  style: TextStyle(
                    color: Theme.of(context).accentColor.withOpacity(1),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Container(
              height: 70,
              width: 500,
              color: Colors.transparent,
              child: Text(
                "CATALOGO DE OFERTAS DE TODOS OS DIAS",
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 24,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Container(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    child: IconButton(
                      icon: Icon(
                        Icons.tune,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    child: IconButton(
                      icon: Icon(
                        CupertinoIcons.search,
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
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ConfigPage();
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scrollbar buildScrollbar(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          Container(
            height: 100,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "CATEGORIAS EM DESTAQUES",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  child: Text(
                    "VER MAIS",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CategoriaPageList();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            alignment: Alignment.center,
          ),
          Container(
            height: 300,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 50, right: 50),
            child: CategoriaListHome(),
          ),
          SizedBox(height: 20),
          Container(
            height: 70,
            padding: EdgeInsets.only(top: 0, left: 40, right: 40),
            child: ListTile(
              leading: Text(
                "Promoções em destaque",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              title: Text(
                "todos os dias",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: RaisedButton(
                padding: EdgeInsets.only(left: 50, right: 50),
                color: Theme.of(context).accentColor,
                child: Text("VER MAIS", style: TextStyle(fontWeight: FontWeight.bold),),
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
          ),
          Container(
            height: 500,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 50, right: 50),
            child: PromocaoListHome(),
          ),
          SizedBox(height: 20),
          Container(
            height: 70,
            padding: EdgeInsets.only(top: 0, left: 40, right: 40),
            child: ListTile(
              leading: Text(
                "Produtos em destaque",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              title: Text(
                "todos os dias",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: RaisedButton(
                padding: EdgeInsets.only(left: 50, right: 50),
                color: Theme.of(context).accentColor,
                child: Text("VER MAIS", style: TextStyle(fontWeight: FontWeight.bold),),
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
          ),
          Container(
            height: 200,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 50, right: 50),
            child: ProdutoListHome(),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
