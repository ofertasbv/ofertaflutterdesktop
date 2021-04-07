import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
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
import 'package:nosso/src/core/repository/produto_repository.dart';
import 'package:nosso/src/paginas/produto/produto_create_page.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_tab.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class ProdutoTable extends StatefulWidget {
  ProdutoFilter filter;

  ProdutoTable({Key key, this.filter}) : super(key: key);

  @override
  _ProdutoTableState createState() => _ProdutoTableState(filter: this.filter);
}

class _ProdutoTableState extends State<ProdutoTable> {
  var produtoController = GetIt.I.get<ProdutoController>();
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();
  var marcaController = GetIt.I.get<MarcaController>();
  var lojaController = GetIt.I.get<LojaController>();
  var nomeController = TextEditingController();

  _ProdutoTableState({this.filter});

  ProdutoFilter filter;
  SubCategoria subCategoria;
  Promocao promocao;
  Marca marca;
  Loja loja;
  Produto produto;

  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");
  RangeValues values = RangeValues(0, 100);
  RangeLabels labels = RangeLabels('0', '100');

  @override
  void initState() {
    if (filter == null) {
      filter = ProdutoFilter();
      subCategoria = SubCategoria();
      promocao = Promocao();
      marca = Marca();
      loja = Loja();
      produto = Produto();
      produtoController.getAll();
    } else {
      produtoController.getFilter(filter);
    }

    subCategoriaController.getAll();
    lojaController.getAll();
    marcaController.getAll();
    promocaoController.getAll();
    super.initState();
  }

  bool isLoading = true;

  pesquisarFilter() {
    print("pesquisa valor mínimo: ${filter.valorMinimo}");
    print("pesquisa valor máximo: ${filter.valorMaximo}");
    print("pesquisa nomeProduto: ${filter.nomeProduto}");
    print("pesquisa subCategoria: ${filter.subCategoria}");
    print("pesquisa promoção: ${filter.promocao}");
    print("pesquisa marca: ${filter.marca}");
    print("pesquisa loja: ${filter.loja}");
    print("pesquisa...");
    produtoController.getFilter(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        title: Text("Produtos"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (produtoController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (produtoController.produtos == null) {
                return Center(
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.warning_amber_outlined),
                  ),
                );
              }

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.white,
                child: Text(
                  (produtoController.produtos.length ?? 0).toString(),
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.tune,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                CupertinoIcons.search,
              ),
              onPressed: () {
                showSearch(context: context, delegate: ProdutoSearchDelegate());
              },
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                promocaoController.getAll();
              },
            ),
          ),
          SizedBox(width: 50),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50, top: 10),
        child: buildContainer(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ProdutoCreatePage();
            }),
          );
        },
      ),
    );
  }

  Container buildContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: new EdgeInsets.all(0),
            color: Colors.grey[100],
            child: Column(
              children: <Widget>[
                RangeSlider(
                  values: values,
                  min: 0,
                  max: 100,
                  labels: labels,
                  divisions: 10,
                  onChanged: (valor) {
                    setState(() {
                      values = valor;
                      double valorMinimo = valor.start;
                      double valorMaximo = valor.end;

                      filter.valorMinimo =
                          double.tryParse(valorMinimo.toStringAsFixed(0));
                      filter.valorMaximo =
                          double.tryParse(valorMaximo.toStringAsFixed(0));

                      labels = RangeLabels(
                          valor.start.toString(), valor.end.toString());

                      print("Valor mínimo: ${filter.valorMinimo}");
                      print("Valor máximo: ${filter.valorMaximo}");
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
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
              onChanged: (nome) {
                filter.nomeProduto = nomeController.text;
                print("produto nome: ${nome}");
                print("produto filter: ${filter.nomeProduto}");
              },
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
                  child: builderConteudoListSubCategorias(),
                ),
                Container(
                  width: 500,
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
                  onPressed: () {
                    pesquisarFilter();
                  },
                  icon: Icon(Icons.search),
                  label: Text("Realizar pesquisa"),
                ),
                RaisedButton.icon(
                  onPressed: () {
                    produtoController.getAll();
                    filter = ProdutoFilter();
                  },
                  icon: Icon(Icons.refresh),
                  label: Text("Atualizar pesquisa"),
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
                loja = l;
                filter.loja = loja.id;
                print("loja nome: ${loja.nome}");
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
                promocao = s;
                filter.promocao = promocao.id;
                print("promoção: ${promocao.nome}");
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
            return CircularProgressorMini();
          }

          return DropdownSearch<Marca>(
            label: "Selecione marcas",
            popupTitle: Center(child: Text("Marcas")),
            items: marcas,
            showSearchBox: true,
            itemAsString: (Marca s) => s.nome,
            isFilteredOnline: true,
            showClearButton: true,
            onChanged: (Marca m) {
              setState(() {
                marca = m;
                filter.marca = marca.id;
                print("marca: ${marca.nome}");
                print("marca filter: ${filter.marca}");
              });
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
                subCategoria = s;
                filter.subCategoria = s.id;
                print("SubCategoria: ${subCategoria.nome}");
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

          return buildTable(produtos);
        },
      ),
    );
  }

  buildTable(List<Produto> produtos) {
    return ListView(
      children: [
        PaginatedDataTable(
          rowsPerPage: 8,
          showCheckboxColumn: false,
          sortColumnIndex: 1,
          sortAscending: true,
          showFirstLastButtons: true,
          columnSpacing: 10,
          columns: [
            DataColumn(label: Text("Cód.")),
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Nome")),
            DataColumn(label: Text("Valor")),
            DataColumn(label: Text("Promoção")),
            DataColumn(label: Text("Categoria")),
            DataColumn(label: Text("Loja")),
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
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

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
        DataCell(Text("${p.id}")),
        DataCell(
          p.foto != null
              ? CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "${produtoController.arquivo + p.foto}",
                  ),
                )
              : CircleAvatar(),
        ),
        DataCell(Text(p.nome)),
        DataCell(Text(
          "R\$ ${formatMoeda.format(p.estoque.valorVenda)}",
          style: TextStyle(color: Colors.red),
        )),
        DataCell(Text(p.promocao.nome)),
        DataCell(Text(p.subCategoria.nome)),
        DataCell(Text(p.loja.nome)),
        DataCell(IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoDetalhesTab(p);
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
