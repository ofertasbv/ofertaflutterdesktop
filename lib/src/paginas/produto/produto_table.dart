import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/produto/produto_create_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class ProdutoTable extends StatefulWidget {
  @override
  _ProdutoTableState createState() => _ProdutoTableState();
}

class _ProdutoTableState extends State<ProdutoTable>
    with AutomaticKeepAliveClientMixin<ProdutoTable> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var nomeController = TextEditingController();

  @override
  void initState() {
    produtoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return produtoController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      produtoController.getAll();
    } else {
      nome = nomeController.text;
      produtoController.getAllByNome(nome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 0),
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.grey[100],
            padding: EdgeInsets.all(5),
            child: ListTile(
              subtitle: TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "busca por nome",
                  prefixIcon: Icon(Icons.search_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => nomeController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
                onChanged: filterByNome,
              ),
            ),
          ),
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
            return Text("Não foi possível carregados dados");
          }

          if (produtos == null) {
            return CircularProgressor();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderTable(produtos),
          );
        },
      ),
    );
  }

  builderTable(List<Produto> produtos) {
    return DataTable(
      sortAscending: true,
      showCheckboxColumn: true,
      showBottomBorder: true,
      columns: [
        DataColumn(label: Text("Código")),
        DataColumn(label: Text("Nome")),
        DataColumn(label: Text("Descrição")),
        DataColumn(label: Text("SubCategoria")),
        DataColumn(label: Text("Loja")),
        DataColumn(label: Text("Marca")),
        DataColumn(label: Text("Editar")),
        DataColumn(label: Text("Detalhes")),
      ],
      rows: produtos
          .map(
            (p) => DataRow(
              onSelectChanged: (i) {
                setState(() {
                  // selecionaItem(p);
                });
              },
              cells: [
                DataCell(
                  Text("${p.id}"),
                ),
                DataCell(
                  Text("${p.nome}"),
                ),
                DataCell(
                  Text("${p.descricao}"),
                ),
                DataCell(Text(p.subCategoria.nome)),
                DataCell(Text(p.loja.nome)),
                DataCell(Text(p.marca.nome)),
                DataCell(IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProdutoCreatePage(
                            produto: p,
                          );
                        },
                      ),
                    );
                  },
                )),
                DataCell(IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProdutoCreatePage(
                            produto: p,
                          );
                        },
                      ),
                    );
                  },
                )),
              ],
            ),
          )
          .toList(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
