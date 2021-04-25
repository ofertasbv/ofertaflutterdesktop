import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/paginas/loja/loja_list_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/paginas/promocao/promocao_page_list.dart';
import 'package:nosso/src/paginas/seguimento/seguimento_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_login_page.dart';
import 'package:nosso/src/util/Examples/teste_mapa.dart';
import 'package:nosso/src/util/sobre/sobre_page.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          builderBodyBack(),
          menuLateral(context),
        ],
      ),
    );
  }

  builderBodyBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[100].withOpacity(0.2),
            Colors.grey[200].withOpacity(0.9)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  menuLateral(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          color: Theme.of(context).primaryColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                foregroundColor: Theme.of(context).accentColor,
                child: Icon(
                  Icons.account_circle,
                  size: 35,
                ),
                maxRadius: 20,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(0),
                  height: 55,
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text(
                      "BOOKOFERTAS",
                      style: TextStyle(
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.supervisor_account),
          title: Text("Minha conta"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return UsuarioLoginPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.search_outlined),
          title: Text("Buscar"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            showSearch(
              context: context,
              delegate: ProdutoSearchDelegate(),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.list_alt_outlined),
          title: Text("Departamentos"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SeguimentoPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.shop_two),
          title: Text("Promoções"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoPageList();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.local_convenience_store_outlined),
          title: Text("Lojas"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LojaListPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.location_on_outlined),
          title: Text("Encontrar lojas"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TesteMapa();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.info_outline),
          title: Text("Sobre"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SobrePage();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
