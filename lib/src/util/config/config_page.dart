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
                  height: 190,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(left: 50, right: 50, top: 10),
                  child: buildGridViewHeader(context),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: buildGridViewConfig(context),
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[900],
            Colors.grey[900],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  buildGridViewHeader(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(50),
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
                radius: 30,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                ),
              ),
              title: Text(
                "Fabio Resplandes",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200],
                ),
              ),
              subtitle: Text(
                "ofertasbv@gmail.com",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
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
                color: Theme.of(context).accentColor,
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
                  color: Theme.of(context).accentColor,
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
                color: Theme.of(context).accentColor.withOpacity(1),
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
                  color: Theme.of(context).accentColor,
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
                color: Theme.of(context).accentColor,
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
                  color: Theme.of(context).accentColor,
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
      padding: EdgeInsets.all(50),
      crossAxisCount: 4,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      scrollDirection: Axis.vertical,
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.list_alt_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Categoria"),
              subtitle: Text("Lista de categorias"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.list_alt_sharp,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("SubCategorias"),
              subtitle: Text("lista de subcategorias"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.add_alert_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Promoções"),
              subtitle: Text("lista de promoções"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.add_alert_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Promoção tipo"),
              subtitle: Text("lista de tipos de promoções"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.local_convenience_store_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Lojas"),
              subtitle: Text("lista de lojas"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.person_add_alt,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Clientes"),
              subtitle: Text("lista de clientes"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.supervised_user_circle_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Vendedores"),
              subtitle: Text("lista de vendedores"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.supervised_user_circle,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Usuários"),
              subtitle: Text("lista de usuários"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.vpn_key_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Permissões"),
              subtitle: Text("lista de permissões"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.filter,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Arquivos"),
              subtitle: Text("lista de arquivos"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.list_alt_sharp,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Marcas"),
              subtitle: Text("lista de marcas"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.shop_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Itens"),
              subtitle: Text("lista de itens"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.location_on_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Endereços"),
              subtitle: Text("lista de endereços"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.color_lens_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Cores"),
              subtitle: Text("lista de cores"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.format_size,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Tamanhos"),
              subtitle: Text("lista de tamanhos"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.shop_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Pedidos"),
              subtitle: Text("lista de pedidos"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.favorite_border_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Favoritos"),
              subtitle: Text("lista de favoritos"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.credit_card_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Cartões"),
              subtitle: Text("lista de cartões"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.payment_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Pagamentos"),
              subtitle: Text("lista de pagamentos"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.recent_actors_outlined,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Fluxos"),
              subtitle: Text("lista de fluxos de caixas"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.recent_actors,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Caixas"),
              subtitle: Text("lista de caixas"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.recent_actors,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Caixas entradas"),
              subtitle: Text("lista de caixas entradas"),
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
            width: 200,
            child: ListTile(
              leading: Icon(
                Icons.recent_actors,
                size: 40,
                color: Theme.of(context).accentColor.withOpacity(1),
              ),
              title: Text("Caixas saídas"),
              subtitle: Text("lista de caixas saídas"),
            ),
          ),
        ),
      ],
    );
  }
}
