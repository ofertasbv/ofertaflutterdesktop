import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          padding: EdgeInsets.only(top: 0, left: 0, right: 10),
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
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(
                      Icons.shopping_basket,
                      size: 30,
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
      );
  }

  Scrollbar buildScrollbar(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          Container(
            height: 100,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 10, right: 10),
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
            padding: EdgeInsets.only(top: 0, left: 10, right: 10),
            child: CategoriaListHome(),
          ),
          Container(
            height: 100,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Container(
            height: 500,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 10, right: 10),
            child: PromocaoListHome(),
          ),
          Container(
            height: 100,
            color: Colors.transparent,
            padding: EdgeInsets.only(top: 0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ],
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
