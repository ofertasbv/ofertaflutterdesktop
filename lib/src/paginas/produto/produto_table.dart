import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/controller/marca_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/marca.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/paginas/produto/produto_create_page.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:dropdown_search/dropdown_search.dart';

class ProdutoTable extends StatefulWidget {
  @override
  _ProdutoTableState createState() => _ProdutoTableState();
}

class _ProdutoTableState extends State<ProdutoTable>
    with AutomaticKeepAliveClientMixin<ProdutoTable> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();
  var marcaController = GetIt.I.get<MarcaController>();
  var lojaController = GetIt.I.get<LojaController>();
  var nomeController = TextEditingController();

  ProdutoFilter filter;
  SubCategoria subCategoria;
  Promocao promocao;
  Marca marca;
  Loja loja;

  @override
  void initState() {
    produtoController.getFilter(filter);
    subCategoriaController.getAll();
    lojaController.getAll();
    marcaController.getAll();
    promocaoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return produtoController.getFilter(filter);
  }

  bool isLoading = true;

  filterByNome(String nome) {
    filter = ProdutoFilter();
    if (nome.trim().isEmpty) {
      produtoController.getFilter(filter);
    } else {
      nome = nomeController.text;
      filter.nomeProduto = nome;
      filter.subCategoria = 1;
      print("nomeProduto: ${filter.nomeProduto}");
      produtoController.getFilter(filter);
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
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.grey[100],
            padding: EdgeInsets.all(0),
            child: TextFormField(
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
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 500,
                  color: Colors.grey[200],
                  child: builderConteudoListSubCategorias(),
                ),
                Container(
                  width: 500,
                  color: Colors.grey[200],
                  child: builderConteudoListMarcas(),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 500,
                  color: Colors.grey[200],
                  child: builderConteudoListLojas(),
                ),
                Container(
                  width: 500,
                  color: Colors.grey[200],
                  child: builderConteudoListPromocaoes(),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton.icon(
                  onPressed: (){},
                  icon: Icon(Icons.search),
                  label: Text("Realizar pesquisa"),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
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
            return CircularProgressor();
          }

          return DropdownSearch<Loja>(
            label: "Selecione lojas",
            popupTitle: Center(child: Text("Lojas")),
            items: lojas,
            showSearchBox: true,
            itemAsString: (Loja s) => s.nome,
            onChanged: (Loja s) {
              print(s.nome);
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
            return CircularProgressor();
          }

          return DropdownSearch<Promocao>(
            label: "Selecione promocoes",
            popupTitle: Center(child: Text("Promoções")),
            items: promocoes,
            showSearchBox: true,
            itemAsString: (Promocao s) => s.nome,
            onChanged: (Promocao s) {
              print(s.nome);
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

  builderConteudoListMarcas() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Marca> marcas = marcaController.marcas;
          if (marcaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (marcas == null) {
            return CircularProgressor();
          }

          return DropdownSearch<Marca>(
            label: "Selecione marcas",
            popupTitle: Center(child: Text("Marcas")),
            items: marcas,
            showSearchBox: true,
            itemAsString: (Marca s) => s.nome,
            onChanged: (Marca s) {
              print(s.nome);
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por marca",
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
            return CircularProgressor();
          }

          return DropdownSearch<SubCategoria>(
            label: "Selecione categorias",
            popupTitle: Center(child: Text("Categorias")),
            items: subcategorias,
            showSearchBox: true,
            itemAsString: (SubCategoria s) => s.nome,
            onChanged: (SubCategoria s) {
              print(s.nome);
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
            child: buildTable(produtos),
          );
        },
      ),
    );
  }

  buildTable(List<Produto> produtos) {
    return ListView(
      children: [
        PaginatedDataTable(
          rowsPerPage: 8,
          showCheckboxColumn: true,
          sortColumnIndex: 1,
          columns: [
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Descrição")),
            DataColumn(label: Text("Categoria")),
            DataColumn(label: Text("Loja")),
            DataColumn(label: Text("Marca")),
            DataColumn(label: Text("Visualizar")),
            DataColumn(label: Text("Editar")),
          ],
          source: DataSource(produtos, context),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class DataSource extends DataTableSource {
  var produtoController = GetIt.I.get<ProdutoController>();
  BuildContext context;
  List<Produto> produtos;
  int selectedCount = 0;

  DataSource(this.produtos, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= produtos.length) return null;
    Produto p = produtos[index];
    return DataRow.byIndex(
      index: index,
      selected: p.destaque,
      onSelectChanged: (value) {
        if (p.destaque != value) {
          selectedCount += value ? 1 : -1;
          assert(selectedCount >= 0);
          p.destaque = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(p.nome)),
        DataCell(CircleAvatar(
          backgroundColor: Colors.grey[100],
          radius: 20,
          backgroundImage: NetworkImage(
            "${produtoController.arquivo + p.foto}",
          ),
        )),
        DataCell(Text(p.descricao)),
        DataCell(Text(p.subCategoria.nome)),
        DataCell(Text(p.loja.nome)),
        DataCell(Text(p.marca.nome)),
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
      ],
    );
  }

  @override
  int get rowCount => produtos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
