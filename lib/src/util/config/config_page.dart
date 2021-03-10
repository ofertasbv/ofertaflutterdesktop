import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/home/home.dart';
import 'package:nosso/src/paginas/arquivo/arquivo_page.dart';
import 'package:nosso/src/paginas/caixacontrole/caixa_controle_page.dart';
import 'package:nosso/src/paginas/caixafluxo/caixafluxo_page.dart';
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
import 'package:nosso/src/paginas/promocao/promocao_page.dart';
import 'package:nosso/src/paginas/promocaotipo/promocaotipo_page.dart';
import 'package:nosso/src/paginas/subcategoria/subcategoria_page.dart';
import 'package:nosso/src/paginas/tamanho/tamanho_page.dart';
import 'package:nosso/src/paginas/usuario/usuario_page.dart';
import 'package:nosso/src/paginas/vendedor/vendedor_page.dart';
import 'package:nosso/src/util/Examples/teste_mapa.dart';
import 'package:nosso/src/util/barcodigo/leitor_codigo_barra.dart';
import 'package:nosso/src/util/barcodigo/leitor_qr_code.dart';
import 'package:nosso/src/util/componentes/radiolist.dart';

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
            padding: EdgeInsets.only(left: 100, right: 100),
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo,
                      radius: 20,
                      backgroundImage: AssetImage(ConstantApi.urlLogo),
                    ),
                    title: Text("DASHBOARD - PAINEL DE CONTROLE"),
                    subtitle: Text("Novo Repartimento - PÁ, 10-03-2021"),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    color: Colors.grey[100],
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
            Colors.grey[200].withOpacity(0.2),
            Colors.grey[600].withOpacity(0.9)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  buildGridViewConfig(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 2),
      // crossAxisSpacing: 1,
      // mainAxisSpacing: 1,
      crossAxisCount: 4,

      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2.1,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorCodigoBarra();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.qr_code_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
                height: 50,
                width: 100,
              ),
              Text("Code bar", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorQRCode();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  foregroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.qr_code_scanner_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Qr code", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  foregroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.map_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Locais", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.home_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Center(
                child: Text("Home", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoTab();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  foregroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.shopping_basket_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Center(
                child: Text("Produto", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.list_alt_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Categoria", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.list_alt_sharp,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("SubCategoria", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoPage();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  foregroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.add_alert_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Promoção", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  foregroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.add_alert_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Promoção tipo", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  foregroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Loja", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.people_alt_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Cliente", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.people_alt_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Vendedor", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Usuário", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.account_tree_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Permissão", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.photo_album_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Arquivo", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Marca", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.shopping_basket_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Items", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[500],
                  foregroundColor: Colors.white,
                  radius: 20,
                  child: Icon(
                    Icons.location_on_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Endereço", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.color_lens_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Cor", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.format_size_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Tamanho", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Pedido", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.favorite_outline_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Favorito", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.credit_card_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Card Pay", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.credit_card_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Pagamento", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.credit_card_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Controle caixa", style: TextStyle(fontSize: 12)),
            ],
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.credit_card_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("Caixa fluxo", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return TesteRadioList();
                },
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(1),
                  foregroundColor: Colors.grey[100],
                  radius: 20,
                  child: Icon(
                    Icons.credit_card_outlined,
                    size: 20,
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              Text("RadioList", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
