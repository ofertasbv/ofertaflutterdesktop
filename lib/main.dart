import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
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
      statusBarIconBrightness: Brightness.dark,
      // ícones da barra superior
      systemNavigationBarColor: Colors.orangeAccent,
      // cor da barra inferior
      systemNavigationBarIconBrightness: Brightness.dark,
      //
      systemNavigationBarDividerColor: Colors.black,
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
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orangeAccent,
        accentColor: Colors.orangeAccent[400],
        primarySwatch: Colors.grey,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          color: Colors.transparent,
          margin: EdgeInsets.all(0),
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10),
            side: BorderSide(color: Colors.grey[100], width: 1),
          ),
        ),
        buttonTheme: ButtonThemeData(
          splashColor: Colors.black,
          textTheme: ButtonTextTheme.primary,
          height: 50,
          padding: EdgeInsets.all(10),
          alignedDropdown: true,
          buttonColor: Colors.grey[700],
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(0),
            side: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: ConfigPage(),
    );
  }

  buildThemeDataBlue(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.indigo[900],
      accentColor: Colors.yellow[900],
      primarySwatch: Colors.indigo,
      appBarTheme: AppBarTheme(
        elevation: 0,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          headline5: TextStyle(color: Colors.blueAccent),
          headline4: TextStyle(color: Colors.yellow),
          headline3: TextStyle(color: Colors.pink),
          headline2: TextStyle(color: Colors.green),
          headline1: TextStyle(color: Colors.cyan),
        ),
      ),
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Reboto',
            bodyColor: Colors.black,
            displayColor: Colors.yellow[900],
          ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.grey[100],
        elevation: 2,
        titleTextStyle: TextStyle(color: Colors.grey[900]),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10),
          side: BorderSide(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.transparent,
      primaryIconTheme: IconThemeData(color: Colors.white),
      fontFamily: 'Reboto',
      dialogBackgroundColor: Colors.grey[100],
      cardTheme: CardTheme(
        elevation: 0,
        color: Colors.transparent,
        margin: EdgeInsets.all(2),
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey[100], width: 1),
        ),
      ),
      buttonTheme: ButtonThemeData(
        splashColor: Colors.black,
        textTheme: ButtonTextTheme.primary,
        height: 50,
        padding: EdgeInsets.all(10),
        alignedDropdown: true,
        buttonColor: Colors.yellow[900],
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(35),
          side: BorderSide(color: Colors.transparent),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black),
        prefixStyle: TextStyle(color: Colors.green[900]),
        hintStyle: TextStyle(color: Colors.yellow[900]),
        fillColor: Colors.grey[200],
        alignLabelWithHint: true,
        focusColor: Colors.red[900],
        hoverColor: Colors.yellow,
        suffixStyle: TextStyle(color: Colors.green),
        errorStyle: TextStyle(color: Colors.red),
        isDense: true,
        filled: true,
      ),
      hintColor: Colors.brown[500],
      iconTheme: IconThemeData(
        color: Colors.indigo[800],
      ),
      snackBarTheme: SnackBarThemeData(
        actionTextColor: Colors.black,
        backgroundColor: Colors.yellow[900],
      ),
      scaffoldBackgroundColor: Colors.grey[200],
      bottomSheetTheme: BottomSheetThemeData(
        modalElevation: 1,
        backgroundColor: Colors.yellow[900],
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        selectedItemColor: Colors.indigo[900],
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.indigo[900]),
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
//
// void main() {
//   runApp(App());
// }
//
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ImagePickerPage(),
//     );
//   }
// }
//
// class ImagePickerPage extends StatefulWidget {
//   @override
//   _ImagePickerPageState createState() => _ImagePickerPageState();
// }
//
// class _ImagePickerPageState extends State<ImagePickerPage> {
//   Image image;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(image?.semanticLabel ?? ""),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.open_in_browser),
//         onPressed: () async {
//           final _image = await FlutterWebImagePicker.getImage;
//           setState(() {
//             image = _image;
//             print("Arquivos: $image");
//           });
//         },
//       ),
//       body: Center(child: image != null ? image : Text('No data...')),
//     );
//   }
// }
