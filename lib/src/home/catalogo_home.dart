import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/home/categoria_list_home.dart';
import 'package:nosso/src/home/produto_list_home.dart';
import 'package:nosso/src/home/promocao_list_home.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/paginas/promocao/promocao_page.dart';

class CatalogoHome extends StatefulWidget {
  @override
  _CatalogoHomeState createState() => _CatalogoHomeState();
}

class _CatalogoHomeState extends State<CatalogoHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 100, right: 100, top: 1),
      child: Container(
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            SizedBox(height: 5),
            Column(
              children: <Widget>[
                Container(
                  height: 250,
                  padding: EdgeInsets.all(0),
                  child: CategoriaListHome(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Ofertas em destaque",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "veja mais",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return PromocaoPage();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 300,
                  padding: EdgeInsets.all(2),
                  child: PromocaoListHome(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Prouduto em destaque",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "veja mais",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ProdutoTab();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 156,
                  padding: EdgeInsets.all(0),
                  child: ProdutoListHome(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
