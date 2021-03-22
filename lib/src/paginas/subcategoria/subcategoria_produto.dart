import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/favorito.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class SubCategoriaProduto extends StatefulWidget {
  Categoria c;

  SubCategoriaProduto({Key key, this.c}) : super(key: key);

  @override
  _SubCategoriaProdutoState createState() =>
      _SubCategoriaProdutoState(categoria: this.c);
}

class _SubCategoriaProdutoState extends State<SubCategoriaProduto>
    with SingleTickerProviderStateMixin {
  _SubCategoriaProdutoState({this.subCategoria, this.categoria});

  var subCategoriaController = GetIt.I.get<SubCategoriaController>();
  var nomeController = TextEditingController();

  SubCategoria subCategoria;
  Categoria categoria;
  Favorito favorito;

  ProdutoFilter filter = ProdutoFilter();
  int size = 0;
  int page = 0;

  @override
  void initState() {
    if (categoria == null) {
      categoria = Categoria();
      subCategoriaController.getAll();
    } else {
      subCategoriaController.getAllByCategoriaById(categoria.id);
    }
    super.initState();
  }

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
    var text = "";

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 50,
        elevation: 0,
        title: categoria.nome == null
            ? Text("Departamentos")
            : Text(categoria.nome),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (subCategoriaController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (subCategoriaController.subCategorias == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                child: Text(
                  (subCategoriaController.subCategorias.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
            foregroundColor: Colors.black,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                subCategoriaController.getAll();
              },
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.grey[200],
              padding: EdgeInsets.all(0),
              child: ListTile(
                subtitle: TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: "busca por departamentos",
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
            SizedBox(height: 10),
            Expanded(
              child: Container(
                color: Colors.grey[200],
                padding: EdgeInsets.only(bottom: 10),
                child: builderConteutoListSubCategoria(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  builderConteutoListSubCategoria() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<SubCategoria> subCategorias =
              subCategoriaController.subCategorias;
          if (subCategoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (subCategorias == null) {
            return Center(
              child: CircularProgressorMini(),
            );
          }

          if (subCategorias.length == 0) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Icon(
                      Icons.mood_outlined,
                      size: 100,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  Text(
                    "Ops! sem departamento",
                  ),
                ],
              ),
            );
          }
          return builderListSubCategoria(subCategorias);
        },
      ),
    );
  }

  builderListSubCategoria(List<SubCategoria> categorias) {
    double containerWidth = 160;
    double containerHeight = 20;

    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: categorias.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        SubCategoria c = categorias[index];

        return GestureDetector(
          child: Container(
            color: Colors.white,
            child: ListTile(
                isThreeLine: false,
                leading: Container(
                  padding: EdgeInsets.all(1),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Theme.of(context).primaryColor,
                    radius: 20,
                    child: Text(
                      c.nome.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                title: Text(c.nome),
                subtitle: Text("${c.categoria.nome}"),
                trailing: Chip(
                  label: Text("${c.produtos.length}"),
                  backgroundColor: Theme.of(context).accentColor,
                )),
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
}
