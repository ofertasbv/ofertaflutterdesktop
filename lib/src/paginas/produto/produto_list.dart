import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/src/api/observable_collections.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/content.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_tab.dart';
import 'package:nosso/src/util/container/container_produto.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class ProdutoList extends StatefulWidget {
  ProdutoFilter filter;

  ProdutoList({Key key, this.filter}) : super(key: key);

  @override
  _ProdutoListState createState() => _ProdutoListState(filter: filter);
}

class _ProdutoListState extends State<ProdutoList>
    with AutomaticKeepAliveClientMixin<ProdutoList> {
  _ProdutoListState({this.filter});

  var produtoController = GetIt.I.get<ProdutoController>();
  SubCategoria s;

  ProdutoFilter filter = ProdutoFilter();
  int size = 0;
  int page = 0;

  @override
  void initState() {
    if (filter == null) {
      produtoController.getAll();
    } else {
      produtoController.getFilter(filter);
    }
    super.initState();
  }

  Future<void> onRefresh() {
    return produtoController.getFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 0),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: builderConteudoList(),
            ),
          ),
        ],
      ),
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Produto> produtos = produtoController.produtos;
          if (produtoController.error != null) {
            return Text("Não foi possível buscar produtos");
          }

          if (produtos == null) {
            return CircularProgressorMini();
          }

          if (produtos.length == 0) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Icon(
                      Icons.mood_outlined,
                      size: 100,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    "Ops! sem produtos",
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderListProduto(produtos),
          );
        },
      ),
    );
  }

  builderListProduto(List<Produto> produtos) {
    var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");
    double containerWidth = 250;
    double containerHeight = 20;

    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: produtos.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        Produto p = produtos[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Container(
              color: Colors.grey[200],
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    height: 150,
                    color: Colors.grey[600],
                    padding: EdgeInsets.all(0),
                    child: p.foto != null
                        ? Container(
                            width: 200,
                            height: 150,
                            color: Colors.grey[600],
                            child: Image.network(
                              "${produtoController.arquivo + p.foto}",
                              width: 200,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 200,
                            height: 150,
                            color: Colors.grey[600],
                            child: Image.asset(
                              ConstantApi.urlLogo,
                              width: 200,
                              height: 150,
                            ),
                          ),
                  ),
                  Container(
                    width: 500,
                    height: 150,
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.center,
                    child: ListTile(
                      title: Text(
                        p.nome,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${p.loja.nome}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 150,
                    color: Colors.grey[300],
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Chip(
                          backgroundColor: Theme.of(context).accentColor,
                          label: Text(
                            "R\$ ${formatMoeda.format(p.estoque.valorUnitario)}",
                            style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                              decorationStyle: TextDecorationStyle.dashed,
                            ),
                          ),
                        ),
                        Text(
                          "R\$ ${formatMoeda.format(p.estoque.valorVenda)}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${p.promocao.nome}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    width: 300,
                    child: Container(
                      width: 300,
                      height: 50,
                      padding: EdgeInsets.all(50),
                      child: RaisedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ProdutoDetalhesTab(p);
                              },
                            ),
                          );
                        },
                        icon: Icon(Icons.add),
                        label: Text("LISTA DE DESEJO"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
