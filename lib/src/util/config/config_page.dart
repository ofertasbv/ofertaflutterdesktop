import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/home/home.dart';
import 'package:nosso/src/paginas/arquivo/arquivo_page.dart';
import 'package:nosso/src/paginas/caixa/caixa_page.dart';
import 'package:nosso/src/paginas/caixacontrole/caixa_controle_page.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_page.dart';
import 'package:nosso/src/paginas/caixafluxoentrada/caixafluxoentrada_page.dart';
import 'package:nosso/src/paginas/caixafluxosaida/caixafluxosaida_page.dart';
import 'package:nosso/src/paginas/cartao/cartao_page.dart';
import 'package:nosso/src/paginas/categoria/categoria_page.dart';
import 'package:nosso/src/paginas/cliente/cliente_page.dart';
import 'package:nosso/src/paginas/cor/cor_page.dart';
import 'package:nosso/src/paginas/endereco/endereco_page.dart';
import 'package:nosso/src/paginas/favorito/favorito_page.dart';
import 'package:nosso/src/paginas/loja/loja_page.dart';
import 'package:nosso/src/paginas/marca/marca_page.dart';
import 'package:nosso/src/paginas/medida/medida_table.dart';
import 'package:nosso/src/paginas/pagamento/pagamento_page.dart';
import 'package:nosso/src/paginas/pedido/pedido_page.dart';
import 'package:nosso/src/paginas/pedido/pedido_table.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_page.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_table.dart';
import 'package:nosso/src/paginas/permissao/permissao_page.dart';
import 'package:nosso/src/paginas/produto/produto_table.dart';
import 'package:nosso/src/paginas/promocao/promocao_table.dart';
import 'package:nosso/src/paginas/promocaotipo/promocaotipo_page.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_page.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_page.dart';
import 'package:nosso/src/paginas/vendedor/vendedor_page.dart';
import 'package:nosso/src/util/Examples/teste_mapa.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          builderBodyBack(),
          Container(
            padding: EdgeInsets.only(left: 0, right: 0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                      children: [
                        Container(
                          width: 400,
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 188,
                                width: double.infinity,
                                color: Colors.grey[800],
                                padding:
                                    EdgeInsets.only(left: 0, right: 0, top: 40),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Icon(Icons.shopping_basket_outlined),
                                    radius: 40,
                                  ),
                                  title: Text(
                                    "OFERTASBV",
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Painel de controle",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: ListTile(
                                  title: Text(
                                    "SHOW SMART OFFERS",
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: ListTile(
                                  title: Text(
                                    "OFERTAS TODOS OS DIAS PRA VOCÊ!",
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Em todas as plataformas",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.all(20),
                                child: FlatButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return HomePage();
                                        },
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.home_outlined),
                                  label: Text("VOLTAR PRA HOME"),
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: buildGridViewConfig(context),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  builderBodyBack() {
    return Opacity(
      opacity: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[800],
              Colors.grey[900],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  buildGridViewConfig(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoriaPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue[600],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.list_alt_outlined,
                size: 40,
                color: Colors.grey[100],
              ),
              subtitle: Text(
                "Lista de categorias",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SubcategoriaPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.deepOrange[600],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.list_alt_sharp,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de subcategorias",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoTable();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.green[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.shopping_basket_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "Lista de produtos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoTable();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.deepPurple[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.add_alert_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de promoções",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoTipoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.pink[600],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.add_alert_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de tipos de promoções",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LojaPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.indigo[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.local_convenience_store_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de lojas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ClientePage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.grey[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.person_add_alt,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de clientes",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return VendedorPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.grey[600],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.supervised_user_circle_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de vendedores",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return UsuarioPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.cyan[600],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.supervised_user_circle,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de usuários",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PermissaoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.purple[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.vpn_key_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de permissões",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ArquivoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.red[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.filter,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de arquivos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return MarcaPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.amber[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.list_alt_sharp,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de marcas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PedidoItemTable();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.yellow[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.shop_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de itens",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return EnderecoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.deepPurpleAccent,
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.location_on_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de endereços",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CorPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blueGrey[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.color_lens_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de cores",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TamanhoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.purple,
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.format_size,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de tamanhos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return MedidaTable();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.purple,
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.format_size,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de medidas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PedidoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.shop_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de pedidos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return FavoritoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.redAccent,
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.favorite_border_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de favoritos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CartaoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.indigo[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.credit_card_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de cartões",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PagamentoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.teal[800],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.payment_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de pagamentos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaFluxoPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.grey[700],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.recent_actors_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de fluxos de caixas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.grey[700],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.recent_actors,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de caixas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaFluxoEntradaPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.grey[700],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.recent_actors,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de caixas entradas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CaixaFluxoSaidaPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.grey[700],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.recent_actors,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "lista de caixas saídas",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
