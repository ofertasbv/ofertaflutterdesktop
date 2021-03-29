import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/arquivo_controller.dart';
import 'package:nosso/src/core/controller/caixa_controller.dart';
import 'package:nosso/src/core/controller/caixafluxo_controller.dart';
import 'package:nosso/src/core/controller/caixafluxoentrada_controller.dart';
import 'package:nosso/src/core/controller/caixafluxosaida_controller.dart';
import 'package:nosso/src/core/controller/cartao_controller.dart';
import 'package:nosso/src/core/controller/categoria_controller.dart';
import 'package:nosso/src/core/controller/cidade_controller.dart';
import 'package:nosso/src/core/controller/cliente_controller.dart';
import 'package:nosso/src/core/controller/cor_controller.dart';
import 'package:nosso/src/core/controller/endereco_controller.dart';
import 'package:nosso/src/core/controller/estado_controller.dart';
import 'package:nosso/src/core/controller/favorito_controller.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/controller/marca_controller.dart';
import 'package:nosso/src/core/controller/medida_controller.dart';
import 'package:nosso/src/core/controller/pagamento_controller.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/controller/permissao_controller.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/controller/promocaotipo_controller.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';

import 'package:flutter/services.dart';
import 'package:nosso/src/core/controller/tamanho_controller.dart';
import 'package:nosso/src/core/controller/usuario_controller.dart';
import 'package:nosso/src/core/controller/vendedor_controller.dart';
import 'package:nosso/src/home/categoria_list_home.dart';
import 'package:nosso/src/home/categoria_list_menu.dart';
import 'package:nosso/src/home/promocao_list_home.dart';
import 'package:nosso/src/paginas/promocao/promocao_page_list.dart';
import 'package:nosso/src/util/config/config_page.dart';
import 'package:nosso/src/util/themes/theme.dart';

void main() async {
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<ArquivoController>(ArquivoController());
  getIt.registerSingleton<CategoriaController>(CategoriaController());
  getIt.registerSingleton<SubCategoriaController>(SubCategoriaController());
  getIt.registerSingleton<PromoCaoController>(PromoCaoController());
  getIt.registerSingleton<PromocaoTipoController>(PromocaoTipoController());
  getIt.registerSingleton<ProdutoController>(ProdutoController());
  getIt.registerSingleton<EnderecoController>(EnderecoController());
  getIt.registerSingleton<PedidoController>(PedidoController());
  getIt.registerSingleton<PedidoItemController>(PedidoItemController());

  getIt.registerSingleton<PermissaoController>(PermissaoController());
  getIt.registerSingleton<ClienteController>(ClienteController());
  getIt.registerSingleton<LojaController>(LojaController());
  getIt.registerSingleton<MarcaController>(MarcaController());
  getIt.registerSingleton<EstadoController>(EstadoController());
  getIt.registerSingleton<CidadeController>(CidadeController());
  getIt.registerSingleton<TamanhoController>(TamanhoController());
  getIt.registerSingleton<CorController>(CorController());
  getIt.registerSingleton<FavoritoController>(FavoritoController());
  getIt.registerSingleton<UsuarioController>(UsuarioController());
  getIt.registerSingleton<VendedorController>(VendedorController());
  getIt.registerSingleton<CartaoController>(CartaoController());
  getIt.registerSingleton<PagamentoController>(PagamentoController());
  getIt.registerSingleton<CaixaController>(CaixaController());
  getIt.registerSingleton<CaixafluxoController>(CaixafluxoController());
  getIt.registerSingleton<MedidaController>(MedidaController());

  getIt.registerSingleton<CaixafluxosaidaController>(
      CaixafluxosaidaController());
  getIt.registerSingleton<CaixafluxoentradaController>(
      CaixafluxoentradaController());

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // cor da barra superior
      statusBarIconBrightness: Brightness.light,
      // ícones da barra superior
      systemNavigationBarColor: Colors.orangeAccent,
      // cor da barra inferior
      systemNavigationBarIconBrightness: Brightness.dark,
      //
      systemNavigationBarDividerColor: Colors.transparent,
      // ícones da barra inferior
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getTheme(context),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: WidgetTree(),
    );
  }
}

class WidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveLayout(
        iphone: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.pink,
        ),
        ipad: Row(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                width: 500,
                height: double.infinity,
                color: Colors.green,
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                width: 500,
                height: double.infinity,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        macbook: Scrollbar(
          child: ListView(
            children: [
              Container(
                height: 80,
                color: Colors.blue[800],
                child: Container(
                  color: Colors.transparent,
                  width: 800,
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
                          title: Text(
                            "BOOK OFERTAS",
                            style: TextStyle(
                              color: Colors.deepOrange[300],
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        height: 70,
                        width: 500,
                        color: Colors.transparent,
                        child: Text(
                          "CATALOGO DE OFERTAS DE TODOS OS DIAS",
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 24,
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        height: 70,
                        width: 200,
                        color: Colors.transparent,
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ConfigPage();
                                  },
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.dashboard,
                              color: Colors.grey[200],
                            ),
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                color: Colors.deepOrange[400],
                padding: EdgeInsets.only(top: 0, left: 60, right: 50),
                child: Container(
                  child: CategoriaListMenu(),
                ),
              ),
              Container(
                height: 1500,
                child: Row(
                  children: [
                    Expanded(
                      flex: _size.width > 1340 ? 1 : 2,
                      child: Container(
                        height: double.infinity,
                        color: Colors.grey[100],
                      ),
                    ),
                    Expanded(
                      flex: _size.width > 1340 ? 22 : 24,
                      child: Container(
                        height: double.infinity,
                        color: Colors.grey[100],
                        child: Column(
                          children: [
                            Container(
                              height: 300,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 100,
                              color: Colors.grey[100],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "DESTAQUES DA SEMANA",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      "VER MAIS",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PromocaoPageList();
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 400,
                              color: Colors.transparent,
                              child: PromocaoListHome(),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 100,
                              color: Colors.grey[100],
                              child: Text(
                                "CATEGORIAS EM DESTAQUE",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              alignment: Alignment.center,
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 300,
                              color: Colors.transparent,
                              child: CategoriaListHome(),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 100,
                              color: Colors.grey[100],
                              child: Text(
                                "PRODUTOS EM DESTAQUE",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              alignment: Alignment.center,
                            ),
                            SizedBox(height: 10),
                            Expanded(
                              child: Container(
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: _size.width > 1340 ? 1 : 2,
                      child: Container(
                        height: double.infinity,
                        color: Colors.grey[100],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget iphone;
  final Widget ipad;
  final Widget macbook;

  const ResponsiveLayout({Key key, this.ipad, this.iphone, this.macbook})
      : super(key: key);

  static int iphoneLimit = 600;
  static int ipadLimit = 1200;

  static bool isIphone(BuildContext context) =>
      MediaQuery.of(context).size.width < iphoneLimit;

  static bool isIpad(BuildContext context) =>
      MediaQuery.of(context).size.width < ipadLimit &&
      MediaQuery.of(context).size.width >= iphoneLimit;

  static bool isMacbook(BuildContext context) =>
      MediaQuery.of(context).size.width >= ipadLimit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < iphoneLimit) {
          return iphone;
        }
        if (constraints.maxWidth < ipadLimit) {
          return ipad;
        } else {
          return macbook;
        }
      },
    );
  }
}
