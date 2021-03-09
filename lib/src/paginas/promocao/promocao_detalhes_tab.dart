import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/paginas/promocao/promocao_detalhes-view.dart';
import 'package:nosso/src/paginas/promocao/promocao_detalhes_info.dart';
import 'package:nosso/src/paginas/promocao/promocao_page.dart';

class PromocaoDetalhesTab extends StatefulWidget {
  Promocao p;

  PromocaoDetalhesTab(this.p);

  @override
  _PromocaoDetalhesTabState createState() => _PromocaoDetalhesTabState();
}

class _PromocaoDetalhesTabState extends State<PromocaoDetalhesTab>
    with SingleTickerProviderStateMixin {
  var promocaoController = GetIt.I.get<PromoCaoController>();
  Promocao promocao;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showDefaultSnackbar(BuildContext context, String content) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(content),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    promocao = widget.p;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(promocao.nome),
          actions: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.4),
              foregroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: ProdutoSearchDelegate(),
                  );
                },
              ),
            ),
            SizedBox(width: 10),
          ],
          bottom: TabBar(
            indicatorPadding: EdgeInsets.only(right: 6, left: 6),
            labelPadding: EdgeInsets.only(right: 6, left: 6),
            tabs: <Widget>[
              Tab(
                child: Text("VISÃO GERAL"),
              ),
              Tab(
                child: Text("INFORMAÇÕES"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            PromocaoDetalhesView(promocao),
            PromocaoDetalhesInfo(promocao)
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(context),
      ),
    );
  }

  buildBottomNavigationBar(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: FlatButton.icon(
                icon: Icon(Icons.list_alt),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: Colors.blue),
                ),
                color: Colors.white,
                textColor: Colors.blue,
                padding: EdgeInsets.all(10),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProdutoTab();
                      },
                    ),
                  );
                },
                label: Text(
                  "VER MAIS".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 2,
              child: FlatButton.icon(
                icon: Icon(Icons.shopping_basket),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: Colors.green),
                ),
                color: Colors.white,
                textColor: Colors.green,
                padding: EdgeInsets.all(10),
                onPressed: () {},
                label: Text(
                  "LISTA DE DESEJO".toUpperCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
