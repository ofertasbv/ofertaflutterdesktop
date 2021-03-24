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
          macbook: ListView(
            children: [
              Container(
                height: 80,
                color: Colors.grey[600],
              ),
              Container(
                height: 50,
                color: Colors.deepOrange[400],
              ),
              Container(
                height: 1500,
                child: Row(
                  children: [
                    Expanded(
                      flex: _size.width > 1340 ? 1 : 2,
                      child: Container(
                        height: double.infinity,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      flex: _size.width > 1340 ? 8 : 10,
                      child: Container(
                        height: double.infinity,
                        color: Colors.blue,
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 100,
                              color: Colors.red[400],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 300,
                              color: Colors.grey[600],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 100,
                              color: Colors.red[400],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 300,
                              color: Colors.grey[600],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 100,
                              color: Colors.red[400],
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
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
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
