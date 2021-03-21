import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/home/categoria_list_home.dart';
import 'package:nosso/src/home/produto_list_home.dart';
import 'package:nosso/src/home/promocao_list_home.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/paginas/promocao/promocao_page.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_produto.dart';
import 'package:nosso/src/util/load/shimmerListCategoriaHome.dart';
import 'package:nosso/src/util/load/shimmerListProdutoHome.dart';
import 'package:nosso/src/util/load/shimmerListPromocaoHome.dart';

class CatalogoHome extends StatefulWidget {
  @override
  _CatalogoHomeState createState() => _CatalogoHomeState();
}

class _CatalogoHomeState extends State<CatalogoHome> {
  var isDataFetched = false;

  @override
  void initState() {
    super.initState();

    Timer timer = Timer(Duration(seconds: 3), () {
      setState(() {
        isDataFetched = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 100, right: 100, top: 1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100].withOpacity(1),
          border: Border.all(color: Colors.grey[200]),
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            SizedBox(height: 5),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Área de conhecimento",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "veja mais",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return SubCategoriaProduto();
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
                  height: 250,
                  padding: EdgeInsets.all(0),
                  child: isDataFetched == false
                      ? ShimmerListCategoriaHome()
                      : CategoriaListHome(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Ofertas em destaque",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "veja mais",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).accentColor,
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
                  height: 350,
                  padding: EdgeInsets.all(0),
                  child: isDataFetched == false
                      ? ShimmerListPromocaoHome()
                      : PromocaoListHome(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Prouduto em destaque",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      GestureDetector(
                        child: Text(
                          "veja mais",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ProdutoPage();
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
                  padding: EdgeInsets.zero,
                  child: isDataFetched == false
                      ? ShimmerListProdutoHome()
                      : ProdutoListHome(),
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
