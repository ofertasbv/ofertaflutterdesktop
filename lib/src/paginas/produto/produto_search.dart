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

class ProdutoSearchDelegate extends SearchDelegate<Produto> {
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

  carregarSubCategorias() {
    subCategoriaController.getAll();
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
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: lojaSelecionada,
            onChanged: (Loja l) {
              produto.loja = l;
              print("loja: ${produto.loja.nome}");
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
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: promocaoSelecionada,
            onChanged: (Promocao s) {
              produto.promocao = s;
              print("promoção: ${produto.promocao.nome}");
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
            validator: (value) => value == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: subCategoriaSelecionada,
            onChanged: (SubCategoria s) {
              produto.subCategoria = s;
              print("SubCategoria: ${produto.subCategoria.nome}");
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

  showDialogFiltro(BuildContext context) async {
    carregarSubCategorias();
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Filtrar produtos"),
          content: Container(
            height: 150,
            width: double.infinity,
            child: builderConteudoListSubCategorias(),
          ),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(color: Colors.grey),
              ),
              color: Colors.white,
              textColor: Colors.grey,
              padding: EdgeInsets.all(10),
              child: const Text('APLICAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(color: Colors.grey),
              ),
              color: Colors.white,
              textColor: Colors.grey,
              padding: EdgeInsets.all(10),
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = "";
        },
      ),
      IconButton(
        icon: Icon(Icons.tune),
        onPressed: () {
          showDialogFiltro(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
      autofocus: true,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    produtoController.getFilter(filter);
    return Observer(
      builder: (context) {
        List<Produto> produtos = produtoController.produtos;

        if (produtoController.error != null) {
          return Text("Não foi possível buscar produtos");
        }

        if (produtos == null) {
          return CircularProgressorMini();
        }

        final resultados = query.isEmpty
            ? []
            : produtos
                .where(
                  (p) => p.nome.toLowerCase().startsWith(query.toLowerCase()),
                )
                .toList();

        return ListView.builder(
          itemBuilder: (context, index) {
            Produto p = resultados[index];
            return ListTile(
              isThreeLine: false,
              leading: p.foto != null
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "${produtoController.arquivo + p.foto}",
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey[400],
                      radius: 20,
                    ),
              title: RichText(
                text: TextSpan(
                  text: p.nome.substring(0, query.length),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: p.nome.substring(query.length),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
              onTap: () {
                filter.nomeProduto = p.nome.substring(0, 5);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProdutoPage(filter: filter);
                    },
                  ),
                );
              },
            );
          },
          itemCount: resultados.length,
        );
      },
    );
  }
}
