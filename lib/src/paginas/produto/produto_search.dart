import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/categoria/categoria_pesquisa.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_tab.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class ProdutoSearchDelegate extends SearchDelegate<Produto> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var categoriaController = GetIt.I.get<CategoriaController>();

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
    produtoController.getAll();
    return Observer(
      builder: (context) {
        List<Produto> produtos = produtoController.produtos;


        if (produtoController.error != null) {
          return Text("Não foi possível buscar produtos");
        }

        if (produtos == null) {
          return CircularProgressor();
        }

        final resultados = query.isEmpty
            ? []
            : produtos
                .where(
                    (p) => p.nome.toLowerCase().startsWith(query.toLowerCase()))
                .toList();

        if (resultados.length == 0) {
          return CategoriaPesquisa();
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            Produto p = resultados[index];
            return ListTile(
              isThreeLine: false,
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "${produtoController.arquivo + p.foto}",
                ),
              ),
              title: RichText(
                text: TextSpan(
                    text: p.nome.substring(0, query.length),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: p.nome.substring(query.length),
                          style: TextStyle(color: Colors.grey))
                    ]),
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
          itemCount: resultados.length,
        );
      },
    );
  }
}
