import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/home/categoria_list_home.dart';
import 'package:nosso/src/home/categoria_list_menu.dart';
import 'package:nosso/src/home/promocao_list_home.dart';
import 'package:nosso/src/paginas/categoria/categoria_page_list.dart';
import 'package:nosso/src/paginas/loja/loja_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_banner.dart';
import 'package:nosso/src/paginas/promocao/promocao_page_list.dart';
import 'package:nosso/src/util/config/config_page.dart';
// import 'package:gscarousel/gscarousel.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayout(
        iphone: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.pink,
        ),
        ipad: Row(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                width: 500,
                height: double.infinity,
                color: Colors.green,
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                width: 500,
                height: double.infinity,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        macbook: Scrollbar(
          child: ListView(
            children: [
              Container(
                height: 80,
                color: Colors.blue[800],
                child: Container(
                  color: Colors.transparent,
                  width: 800,
                  padding: EdgeInsets.only(top: 0, left: 50, right: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 70,
                        width: 200,
                        color: Colors.transparent,
                        child: ListTile(
                          leading: Icon(
                            Icons.shopping_basket,
                            size: 55,
                            color: Colors.grey[200],
                          ),
                          title: Text(
                            "BOOK OFERTAS",
                            style: TextStyle(
                              color: Colors.deepOrange[300],
                              fontSize: 20,
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
                        height: 70,
                        width: 200,
                        color: Colors.transparent,
                        child: CircleAvatar(
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
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                color: Colors.deepOrange[400],
                padding: EdgeInsets.only(top: 0, left: 60, right: 50),
                child: Container(
                  child: CategoriaListMenu(),
                ),
              ),
              Container(
                height: 1600,
                child: Row(
                  children: [
                    Expanded(
                      flex: _size.width > 1340 ? 1 : 2,
                      child: Container(
                        height: double.infinity,
                        color: Colors.grey[200],
                      ),
                    ),
                    Expanded(
                      flex: _size.width > 1340 ? 22 : 24,
                      child: Container(
                        height: double.infinity,
                        color: Colors.grey[100],
                        child: Column(
                          children: [
                            Container(
                              height: 400,
                              color: Colors.grey[400],
                              child: PromocaoBanner(),
                            ),
                            Container(
                              height: 100,
                              color: Colors.grey[100],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "DESTAQUES DA SEMANA",
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
                                            return PromocaoPageList();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 400,
                              color: Colors.transparent,
                              child: PromocaoListHome(),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 100,
                              color: Colors.grey[100],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "CATEGORIAS EM DESTAQUE",
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
                            SizedBox(height: 10),
                            Container(
                              height: 300,
                              color: Colors.transparent,
                              child: CategoriaListHome(),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 100,
                              color: Colors.grey[100],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "LOJAS EM DESTAQUE",
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
                                            return LojaPage();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Container(
                                height: 300,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: _size.width > 1340 ? 1 : 2,
                      child: Container(
                        height: double.infinity,
                        color: Colors.grey[100],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget iphone;
  final Widget ipad;
  final Widget macbook;

  const ResponsiveLayout({Key key, this.ipad, this.iphone, this.macbook})
      : super(key: key);

  static int iphoneLimit = 600;
  static int ipadLimit = 1200;

  static bool isIphone(BuildContext context) =>
      MediaQuery.of(context).size.width < iphoneLimit;

  static bool isIpad(BuildContext context) =>
      MediaQuery.of(context).size.width < ipadLimit &&
      MediaQuery.of(context).size.width >= iphoneLimit;

  static bool isMacbook(BuildContext context) =>
      MediaQuery.of(context).size.width >= ipadLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < iphoneLimit) {
          return iphone;
        }
        if (constraints.maxWidth < ipadLimit) {
          return ipad;
        } else {
          return macbook;
        }
      },
    );
  }
}
