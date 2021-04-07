import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/main.dart';
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
import 'package:nosso/src/paginas/pagamento/pagamento_page.dart';
import 'package:nosso/src/paginas/pedido/pedido_page.dart';
import 'package:nosso/src/paginas/pedidoitem/pedidoitem_page.dart';
import 'package:nosso/src/paginas/permissao/permissao_page.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/paginas/produto/produto_table.dart';
import 'package:nosso/src/paginas/promocao/promocao_page.dart';
import 'package:nosso/src/paginas/promocao/promocao_table.dart';
import 'package:nosso/src/paginas/promocaotipo/promocaotipo_page.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_page.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_page.dart';
import 'package:nosso/src/paginas/vendedor/vendedor_page.dart';
import 'package:nosso/src/util/Examples/teste_mapa.dart';
import 'package:nosso/src/util/barcodigo/leitor_codigo_barra.dart';
import 'package:nosso/src/util/barcodigo/leitor_qr_code.dart';

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
                Container(
                  height: 70,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                  child: buildGridViewHeader(context),
                ),
                SizedBox(height: 0),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  child: ListTile(
                                    title: Text(
                                      "PAINEL DE CONTROLE!",
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Em todas as plataformas",
                                      style: TextStyle(fontSize: 30),
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
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Em todas as plataformas",
                                      style: TextStyle(fontSize: 30),
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
                                    color: Colors.blue,
                                  ),
                                )
                              ],
                            )),
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
              Colors.grey[300],
              Colors.grey[600],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  buildGridViewHeader(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(0),
      crossAxisCount: 4,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return HomePage();
                },
              ),
            );
          },
          child: Container(
            width: 200,
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[400],
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 25,
                ),
              ),
              title: Text(
                "Fabio Resplandes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
              subtitle: Text(
                "ofertasbv@gmail.com",
                style: TextStyle(
                  color: Colors.grey[400],
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
                  return HomePage();
                },
              ),
            );
          },
          child: Container(
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.home,
                size: 40,
                color: Colors.grey[400],
              ),
              title: Text(
                "Home page",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
              subtitle: Text(
                "Página inicial",
                style: TextStyle(
                  color: Colors.grey[400],
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
                  return CaixaControlePage();
                },
              ),
            );
          },
          child: Container(
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.account_box_outlined,
                size: 40,
                color: Colors.grey[400],
              ),
              title: Text(
                "Controle de caixa",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
              subtitle: Text(
                "compra e vendas",
                style: TextStyle(
                  color: Colors.grey[400],
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
                  return TesteMapa(
                    androidFusedLocation: true,
                  );
                },
              ),
            );
          },
          child: Container(
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                size: 40,
                color: Colors.grey[400],
              ),
              title: Text(
                "Locais de comerciais",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
              subtitle: Text(
                "Locais de lojas",
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
        ),
      ],
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
            color: Colors.grey[100],
            alignment: Alignment.center,
            child: ListTile(
              title: Icon(
                Icons.list_alt_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              subtitle: Text(
                "Lista de categorias",
                textAlign: TextAlign.center,
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PedidoItemPage();
                },
              ),
            );
          },
          child: Container(
            width: 150,
            height: 150,
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
            color: Colors.grey[100],
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}
