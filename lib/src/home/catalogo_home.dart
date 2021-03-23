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
import 'package:nosso/src/paginas/promocao/promocao_page_list.dart';
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[200].withOpacity(1),
            Colors.grey[100],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: EdgeInsets.only(left: 50, right: 50, top: 1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            SizedBox(height: 5),
            Column(
              children: <Widget>[
                buildContainerTituloCategoria(context),
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
                buildContainerTtituloPromocao(context),
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
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  color: Colors.grey[300],
                  child: Text("Todos os direitods reservados - gdados.com"),
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainerTituloProduto(BuildContext context) {
    return Container(
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
    );
  }

  Container buildContainerTtituloPromocao(BuildContext context) {
    return Container(
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
                    return PromocaoPageList();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Container buildContainerTituloCategoria(BuildContext context) {
    return Container(
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
    );
  }
}
