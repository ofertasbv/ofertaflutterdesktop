import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/core/model/usuario.dart';
import 'package:nosso/src/home/home.dart';
import 'package:nosso/src/paginas/categoria/categoria_page.dart';
import 'package:nosso/src/paginas/loja/loja_page.dart';
import 'package:nosso/src/paginas/pedido/pedido_page.dart';
import 'package:nosso/src/paginas/produto/produto_search.dart';
import 'package:nosso/src/paginas/promocao/promocao_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_login_page.dart';
import 'package:nosso/src/util/config/config_page.dart';
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
            Colors.grey[200].withOpacity(0.2),
            Colors.grey[600].withOpacity(0.9)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  menuLateral(BuildContext context) {
    var usuarioController = GetIt.I.get<UsuarioController>();
    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                foregroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.account_circle,
                  size: 25,
                ),
                maxRadius: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Observer(
                      builder: (context) {
                        Usuario u = usuarioController.usuarioSelecionado;
                        if (u == null) {
                          return Text("Minha conta");
                        }
                        return Text(
                          "${u.email}",
                          style: TextStyle(
                            color: Colors.grey[900],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
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
          leading: Icon(Icons.account_circle_outlined),
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
          leading: Icon(Icons.shopping_basket),
          title: Text("Meus pedidos"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PedidoPage();
                },
              ),
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
                  return CategoriaPage();
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
                  return PromocaoPage();
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
                  return LojaPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: false,
          leading: Icon(Icons.apps),
          title: Text("Apps"),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfigPage(),
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
