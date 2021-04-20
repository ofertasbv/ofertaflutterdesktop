import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/paginas/produto/produto_filter_page.dart';
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
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();
  var categoriaController = GetIt.I.get<CategoriaController>();
  var lojaController = GetIt.I.get<LojaController>();
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var nomeController = TextEditingController();

  ProdutoFilter filter;
  SubCategoria subCategoriaSelecionada;
  Loja lojaSelecionada;
  Promocao promocaoSelecionada;
  Produto produto;
  String pagina = "";

  _ProdutoPageState({this.filter});

  @override
  void initState() {
    produtoController.getFilter(filter);
    subCategoriaController.getAll();
    lojaController.getAll();
    promocaoController.getAll();
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

  builderConteudoListLojas() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Loja> lojas = lojaController.lojas;
          if (lojaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (lojas == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Loja>(
            label: "Selecione lojas",
            popupTitle: Center(child: Text("Lojas")),
            items: lojas,
            showSearchBox: true,
            itemAsString: (Loja s) => s.nome,
            isFilteredOnline: true,
            showClearButton: true,
            onChanged: (Loja l) {
              setState(() {
                lojaSelecionada = l;
                filter.loja = lojaSelecionada.id;
                print("loja nome: ${lojaSelecionada.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por loja",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListPromocaoes() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Promocao> promocoes = promocaoController.promocoes;
          if (promocaoController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (promocoes == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Promocao>(
            label: "Selecione promocoes",
            popupTitle: Center(child: Text("Promoções")),
            items: promocoes,
            showSearchBox: true,
            itemAsString: (Promocao s) => s.nome,
            isFilteredOnline: true,
            showClearButton: true,
            onChanged: (Promocao s) {
              setState(() {
                promocaoSelecionada = s;
                filter.promocao = promocaoSelecionada.id;
                print("promoção: ${promocaoSelecionada.nome}");
                print("promoção filter: ${filter.promocao}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por promoção",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListSubCategorias() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<SubCategoria> subcategorias =
              subCategoriaController.subCategorias;
          if (subCategoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (subcategorias == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<SubCategoria>(
            label: "Selecione categorias",
            popupTitle: Center(child: Text("Categorias")),
            items: subcategorias,
            showSearchBox: true,
            itemAsString: (SubCategoria s) => s.nome,
            isFilteredOnline: true,
            showClearButton: true,
            onChanged: (SubCategoria s) {
              setState(() {
                subCategoriaSelecionada = s;
                filter.subCategoria = s.id;
                print("SubCategoria: ${subCategoriaSelecionada.nome}");
                print("SubCategoria filter: ${filter.subCategoria}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por categoria",
            ),
          );
        },
      ),
    );
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
            height: 100,
            padding: EdgeInsets.only(left: 50, right: 50, top: 0),
            color: Colors.transparent,
            child: Container(
              color: Colors.grey[500],
              child: Container(
                padding: EdgeInsets.all(0),
                color: Colors.grey[300],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.grey[100],
                      child: builderConteudoListLojas(),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.grey[100],
                      child: builderConteudoListPromocaoes(),
                    ),
                    Container(
                      height: 50,
                      width: 300,
                      color: Colors.grey[100],
                      child: builderConteudoListSubCategorias(),
                    ),
                    Container(
                      height: 50,
                      width: 150,
                      child: RaisedButton.icon(
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          produtoController.getFilter(filter);
                        },
                        icon: Icon(Icons.check),
                        label: Text("APLICAR"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 2000,
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
                  fillColor: Colors.deepPurpleAccent.withOpacity(1),
                  hintStyle: TextStyle(color: Colors.white),
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
              width: 250,
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
                  SizedBox(width: 5),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Colors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.tune,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ProdutoFilterPage();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 5),
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
                        filter = ProdutoFilter();
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
