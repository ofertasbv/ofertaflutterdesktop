import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/produto/produto_grid.dart';
import 'package:nosso/src/paginas/produto/produto_list.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class ProdutoPage extends StatefulWidget {
  ProdutoFilter filter;

  ProdutoPage({Key key, this.filter}) : super(key: key);

  @override
  _ProdutoPageState createState() => _ProdutoPageState(filter: this.filter);
}

class _ProdutoPageState extends State<ProdutoPage> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var nomeController = TextEditingController();

  ProdutoFilter filter = ProdutoFilter();
  String pagina = "";

  _ProdutoPageState({this.filter});

  @override
  void initState() {
    produtoController.getFilter(filter);
    super.initState();
  }

  Future<void> onRefresh() {
    return produtoController.getFilter(filter);
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      produtoController.getFilter(filter);
    } else {
      nome = nomeController.text;
      produtoController.getAllByNome(nome);
    }
  }

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

  Scrollbar buildScrollbar(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          Container(
            height: 1000,
            padding: EdgeInsets.only(left: 50, right: 50, top: 10),
            child: pagina == "list"
                ? ProdutoList(filter: filter)
                : ProdutoGrid(filter: filter),
          ),
        ],
      ),
    );
  }

  Container buildContainerHeader(BuildContext context) {
    return Container(
      height: 80,
      color: Theme.of(context).primaryColor,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
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
                    color: Colors.grey[100],
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
              alignment: Alignment.center,
              child: TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  hintText: "busca por produtos",
                  suffixIcon: IconButton(
                    onPressed: () => nomeController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
                onChanged: filterByNome,
              ),
            ),
            Container(
              height: 70,
              width: 200,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(
                    builder: (context) {
                      List<Produto> produtos = produtoController.produtos;
                      if (produtoController.error != null) {
                        return Text("Não foi possível buscar produtos");
                      }

                      if (produtos == null) {
                        return CircularProgressorMini();
                      }

                      return CircleAvatar(
                        child: Text(
                          (produtoController.produtos.length ?? 0).toString(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(1),
                    foregroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.dashboard,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        setState(() {
                          pagina = "grid";
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(1),
                    foregroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.table_rows,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        setState(() {
                          pagina = "list";
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).accentColor.withOpacity(1),
                    foregroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        produtoController.getAll();
                      },
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
}
