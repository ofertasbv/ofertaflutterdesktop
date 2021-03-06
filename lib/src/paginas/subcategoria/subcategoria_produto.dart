import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/model/categoria.dart';
import 'package:nosso/src/core/model/favorito.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/home/home.dart';
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
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: buildContainerHeader(context),
      ),
      body: buildContainer(context),
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
              height: 80,
              width: 500,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: TextFormField(
                controller: nomeController,
                decoration: InputDecoration(
                  hintText: "busca por subcategorias",
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Observer(
                    builder: (context) {
                      if (subCategoriaController.error != null) {
                        return Text("N??o foi poss??vel carregar");
                      }

                      if (subCategoriaController.subCategorias == null) {
                        return Center(
                          child: Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.grey[200],
                          ),
                        );
                      }

                      return CircleAvatar(
                        child: Text(
                          (subCategoriaController.subCategorias.length ?? 0)
                              .toString(),
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
                        Icons.refresh,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        subCategoriaController.getAll();
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

  Container buildContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, top: 10),
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
            return Text("N??o foi poss??vel carregados dados");
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
            color: Colors.grey[200],
            child: ListTile(
              isThreeLine: false,
              leading: Container(
                padding: EdgeInsets.all(1),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
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
              trailing: CircleAvatar(
                backgroundColor: Colors.grey[100],
                child: Text(c.produtos.length.toString()),
              ),
            ),
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
