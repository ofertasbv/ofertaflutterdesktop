import 'package:dropdown_search/dropdown_search.dart';
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
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class ProdutoFilterPage extends StatefulWidget {
  @override
  _ProdutoFilterPageState createState() => _ProdutoFilterPageState();
}

class _ProdutoFilterPageState extends State<ProdutoFilterPage> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();
  var categoriaController = GetIt.I.get<CategoriaController>();
  var lojaController = GetIt.I.get<LojaController>();
  var promocaoController = GetIt.I.get<PromoCaoController>();

  ProdutoFilter filter = ProdutoFilter();
  SubCategoria subCategoriaSelecionada;
  Loja lojaSelecionada;
  Promocao promocaoSelecionada;
  Produto produto;

  @override
  void initState() {
    if (filter == null) {
      filter = ProdutoFilter();
    }
    subCategoriaController.getAll();
    lojaController.getAll();
    promocaoController.getAll();
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Fitrar produtos"),
        titleSpacing: 10,
        actions: [
          SizedBox(width: 5),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor.withOpacity(1),
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.grey[200],
              ),
              onPressed: () {
                setState(() {
                  filter = ProdutoFilter();
                });
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 50, right: 50, top: 50),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 50,
                    width: 300,
                    color: Colors.grey[200],
                    child: builderConteudoListLojas(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: 300,
                    color: Colors.grey[200],
                    child: builderConteudoListPromocaoes(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: 300,
                    color: Colors.grey[200],
                    child: builderConteudoListSubCategorias(),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ignore: deprecated_member_use
                        Container(
                          height: 50,
                          width: 150,
                          child: RaisedButton.icon(
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              filter = ProdutoFilter();
                              Navigator.of(context).pop();
                            },
                            icon: Icon(Icons.check),
                            label: Text("CANCELAR"),
                          ),
                        ),
                        // ignore: deprecated_member_use
                        Container(
                          height: 50,
                          width: 150,
                          child: RaisedButton.icon(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ProdutoPage(filter: filter);
                                  },
                                ),
                              );
                            },
                            icon: Icon(Icons.check),
                            label: Text("APLICAR"),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
