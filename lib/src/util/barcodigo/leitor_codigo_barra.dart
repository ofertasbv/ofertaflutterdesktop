import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/produto/produto_detalhes_tab.dart';
import 'package:audioplayers/audio_cache.dart';

class LeitorCodigoBarra extends StatefulWidget {
  @override
  _LeitorCodigoBarraState createState() => new _LeitorCodigoBarraState();
}

class _LeitorCodigoBarraState extends State<LeitorCodigoBarra> {
  ProdutoController produtoController = GetIt.I.get<ProdutoController>();

  String barcode = "";
  Produto p;

  var codigoBarraController = TextEditingController();

  AudioCache audioCache = AudioCache(prefix: "audios/");

  @override
  initState() {
    p = Produto();
    audioCache.loadAll(["beep-07.mp3"]);
    super.initState();
  }

  Controller controller;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  executar(String nomeAudio) {
    audioCache.play(nomeAudio + ".mp3");
  }

  showToast(String cardTitle) {
    Fluttertoast.showToast(
      msg: "Atenção: $cardTitle",
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      fontSize: 16.0,
    );
  }

  showSnackbar(BuildContext context, String content) {
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
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Leitor código de barra'),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (this.p.codigoBarra != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProdutoDetalhesTab(p);
                    },
                  ),
                );
              } else {
                showSnackbar(context, "Insira o código válido!");
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey[200],
                    Colors.grey[300],
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff676B76).withOpacity(0.2),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      autofocus: false,
                      controller: codigoBarraController,
                      validator: (value) =>
                          value.isEmpty ? "campo obrigário" : null,
                      decoration: InputDecoration(
                        labelText: "use scanner ou digite aquí",
                        hintText: "entre com o código de barra",
                        prefixIcon: IconButton(
                          onPressed: () => barcodeScanning,
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => codigoBarraController.clear(),
                          icon: Icon(Icons.clear),
                        ),
                        filled: false,
                        fillColor: Colors.grey[600],
                        hintStyle: TextStyle(color: Colors.orangeAccent),
                        labelStyle: TextStyle(color: Colors.orangeAccent),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      maxLength: 13,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 10,
        label: Text("Scanner"),
        icon: Icon(Icons.camera_enhance),
        onPressed: () {
          barcodeScanning();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  buscarByCodigoDeBarra(String codBarra) async {
    p = await produtoController.getCodigoBarra(codBarra).then((value) {
      p = value;
      if (p == null) {
        showSnackbar(context, "Nenhum produto encontrado!");
      }
      return p;
    });
  }

  Future barcodeScanning() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        executar("beep-07");
        this.barcode = barcode;
        codigoBarraController.text = this.barcode;
        buscarByCodigoDeBarra(this.barcode);
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Permissão negada!';
        });
      } else {
        setState(() => this.barcode = 'Ops! erro: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'Nada capturado.');
    } catch (e) {
      setState(() => this.barcode = 'Erros: $e');
    }
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}
