import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/home/home.dart';
import 'package:nosso/src/paginas/promocao/promocao_create_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_list.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';

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
    promocaoController.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return promocaoController.getAll();
  }

  bool isLoading = true;

  filterByNome(String nome) {
    if (nome.trim().isEmpty) {
      promocaoController.getAll();
    } else {
      nome = nomeController.text;
      promocaoController.getAllByNome(nome);
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
      body: buildScrollbar(context),
    );
  }

  Scrollbar buildScrollbar(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          Container(
            height: 1000,
            padding: EdgeInsets.only(left: 50, right: 50, top: 10),
            child: PromocaoList(),
          ),
        ],
      ),
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
                    color: Theme.of(context).accentColor.withOpacity(1),
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
                          child: Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.grey[200],
                          ),
                        );
                      }

                      return CircleAvatar(
                        child: Text(
                          (promocaoController.promocoes.length ?? 0).toString(),
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
    );
  }
}
