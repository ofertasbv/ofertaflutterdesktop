import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:multiselect_dropdown/main.dart';
import 'package:nosso/main.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/promocao/promocao_create_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_list.dart';
import 'package:nosso/src/paginas/promocao/promocao_table.dart';
import 'package:nosso/src/util/container/container_promocao.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';

class PromocaoPageList extends StatefulWidget {
  Loja p;

  PromocaoPageList({Key key, this.p}) : super(key: key);

  @override
  _PromocaoPageListState createState() => _PromocaoPageListState(p: this.p);
}

class _PromocaoPageListState extends State<PromocaoPageList> {
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var nomeController = TextEditingController();

  Loja p;
  ProdutoFilter filter = ProdutoFilter();

  _PromocaoPageListState({this.p});

  @override
  void initState() {
    promocaoController.getAllByStatus(true);
    super.initState();
  }

  Future<void> onRefresh() {
    return promocaoController.getAllByStatus(true);
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      promocaoController.getAllByStatus(true);
    } else {
      nome = nomeController.text;
      promocaoController.getAllByNome(nome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 80,
            color: Colors.blue[800],
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              padding: EdgeInsets.only(top: 0, left: 50, right: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 70,
                    width: 200,
                    color: Colors.transparent,
                    child: ListTile(
                      leading: Icon(
                        Icons.shopping_basket,
                        size: 55,
                        color: Colors.grey[200],
                      ),
                      title: GestureDetector(
                        child: Text(
                          "BOOK OFERTAS",
                          style: TextStyle(
                            color: Colors.deepOrange[300],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
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
                        hintText: "busca por promoções",
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
                            if (promocaoController.error != null) {
                              return Text("Não foi possível carregar");
                            }

                            if (promocaoController.promocoes == null) {
                              return Center(
                                child: Icon(Icons.warning_amber_outlined),
                              );
                            }

                            return CircleAvatar(
                              child: Text(
                                (promocaoController.promocoes.length ?? 0)
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
                            ),
                            onPressed: () {
                              promocaoController.getAll();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1000,
            padding: EdgeInsets.only(left: 50, right: 50, top: 10),
            child: PromocaoList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return PromocaoCreatePage();
            }),
          );
        },
      ),
    );
  }
}
