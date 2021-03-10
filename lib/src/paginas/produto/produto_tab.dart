import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/paginas/produto/produto_create_page.dart';
import 'package:nosso/src/paginas/produto/produto_grid.dart';
import 'package:nosso/src/paginas/produto/produto_list.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/paginas/produto/produto_table.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';

class ProdutoTab extends StatefulWidget {
  ProdutoFilter filter;
  SubCategoria s;

  ProdutoTab({Key key, this.filter, this.s}) : super(key: key);

  @override
  _ProdutoTabState createState() =>
      _ProdutoTabState(filter: this.filter, s: this.s);
}

class _ProdutoTabState extends State<ProdutoTab> {
  _ProdutoTabState({this.filter, this.s});

  var produtoController = GetIt.I.get<ProdutoController>();
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();

  SubCategoria s;
  ProdutoFilter filter;
  int size = 0;
  int page = 0;
  bool destaque = false;
  int elementIndex = 0;
  String selectedCard = 'WEIGHT';

  @override
  void initState() {
    produtoController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text("Produtos"),
          actions: <Widget>[
            Observer(
              builder: (context) {
                if (produtoController.error != null) {
                  return Text("Não foi possível carregar");
                }

                if (produtoController.produtos == null) {
                  return Center(
                    child: Icon(Icons.warning_amber_outlined),
                  );
                }

                return CircleAvatar(
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.4),
                  foregroundColor: Colors.black,
                  child: Text(
                    (produtoController.produtos.length ?? 0).toString(),
                    style: TextStyle(color: Colors.white),
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
                  Icons.tune,
                ),
                onPressed: () {
                  showDialogAlert(context);
                },
              ),
            ),
            SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
              foregroundColor: Colors.black,
              child: IconButton(
                icon: Icon(
                  CupertinoIcons.search,
                ),
                onPressed: () {
                  showSearch(
                      context: context, delegate: ProdutoSearchDelegate());
                },
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 100, right: 100, top: 1),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.transparent,
                  padding: EdgeInsets.all(2),
                  child: builderConteudoListSubCategoria(),
                ),
              ),
              Expanded(
                child: Center(child: lista[elementIndex]),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 10,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProdutoCreatePage();
                },
              ),
            );
          },
        ),
        // bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_on_outlined),
          title: Text('grid'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          title: Text('list'),
        ),
      ],
      currentIndex: elementIndex,
      onTap: changeIndex,
      elevation: 4,
    );
  }

  List lista = [ProdutoTable(), ProdutoTable()];

  changeIndex(int index) {
    setState(() {
      elementIndex = index;
    });
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  verificar() {
    destaque = !destaque;
  }

  builderConteudoListSubCategoria() {
    return Container(
      child: Observer(
        builder: (context) {
          List<SubCategoria> categorias = subCategoriaController.subCategorias;
          if (subCategoriaController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (categorias == null) {
            return CircularProgressorMini();
          }

          return builderListSubCategoria(categorias);
        },
      ),
    );
  }

  builderListSubCategoria(List<SubCategoria> categorias) {
    double containerWidth = 110;
    double containerHeight = 15;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        SubCategoria c = categorias[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Chip(
              label: Text(c.nome.toLowerCase()),
              backgroundColor: c.nome == selectedCard
                  ? Theme.of(context).primaryColor.withOpacity(0.4)
                  : Colors.grey[300],
            ),
          ),
          onTap: () {
            selectCard(c.nome);
            print("id catgeoria ${c.id}");
            produtoController.getAllBySubCategoriaById(c.id);
          },
        );
      },
    );
  }

  showDialogAlert(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Filtro de pesquisa"),
              content: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Checkbox(
                            value: destaque,
                            onChanged: (bool value) {
                              setState(() {
                                destaque = value;
                                // filter.destaque = destaque;
                                // print("Filter destaque: ${filter.destaque}");
                              });
                            },
                          ),
                        ),
                        Center(
                          child: Text("Destaque"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                RaisedButton.icon(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  label: Text('CANCELAR'),
                  color: Colors.grey,
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                RaisedButton.icon(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.yellow[900]),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  label: Text('APLICAR'),
                  color: Colors.yellow[900],
                  elevation: 0,
                  onPressed: () {
                    produtoController.getFilter(filter, size, page);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
