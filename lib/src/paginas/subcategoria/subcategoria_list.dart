import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/util/container/container_subcategoria.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class SubCategoriaList extends StatefulWidget {
  Categoria categoria;

  SubCategoriaList({Key key, this.categoria}) : super(key: key);

  @override
  _SubCategoriaListState createState() =>
      _SubCategoriaListState(categoria: this.categoria);
}

class _SubCategoriaListState extends State<SubCategoriaList>
    with AutomaticKeepAliveClientMixin<SubCategoriaList> {
  _SubCategoriaListState({this.categoria});

  var subCategoriaController = GetIt.I.get<SubCategoriaController>();
  var nomeController = TextEditingController();

  Categoria categoria;
  ProdutoFilter filter = ProdutoFilter();

  @override
  void initState() {
    if (categoria == null) {
      subCategoriaController.getAll();
    } else {
      subCategoriaController.getAllByCategoriaById(categoria.id);
    }
    super.initState();
  }

  Future<void> onRefresh() {
    return subCategoriaController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      subCategoriaController.getAll();
    } else {
      nome = nomeController.text;
      subCategoriaController.getAllByNome(nome);
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
            height: 60,
            width: double.infinity,
            color: Colors.grey[100],
            padding: EdgeInsets.all(0),
            child: ListTile(
              subtitle: TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: "busca por subcategorias",
                  prefixIcon: Icon(Icons.search_outlined),
                  suffixIcon: IconButton(
                    onPressed: () => nomeController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
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
          List<SubCategoria> categorias = subCategoriaController.subCategorias;
          if (subCategoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (categorias == null) {
            return CircularProgressorMini();
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(categorias),
          );
        },
      ),
    );
  }

  builderList(List<SubCategoria> categorias) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        SubCategoria c = categorias[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: ContainerSubCategoria(subCategoriaController, c),
          ),
          onTap: () {
            filter.subCategoria = c.id;
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
