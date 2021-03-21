import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/src/api/observable_collections.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/content.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_tab.dart';
import 'package:nosso/src/util/container/container_produto.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

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

  ProdutoFilter filter;
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
    return produtoController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoList();
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
            return CircularProgressor();
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
              color: Colors.white,
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 600,
                    height: 150,
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: ListTile(
                      leading: p.foto != null
                          ? CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              foregroundColor: Colors.green,
                              radius: 50,
                              backgroundImage: NetworkImage(
                                "${produtoController.arquivo + p.foto}",
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              radius: 50,
                            ),
                      title: Text(
                        p.nome,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text("${p.descricao}"),
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 150,
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: ListTile(
                      title: Text(
                        p.descricao,
                        style: TextStyle(
                          fontSize: 20,
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
                      trailing: Chip(
                        backgroundColor: Theme.of(context).accentColor,
                        label: Text("${p.id}"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoDetalhesTab(p);
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
