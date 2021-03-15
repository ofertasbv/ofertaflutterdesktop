import 'dart:async';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/cor_controller.dart';
import 'package:nosso/src/core/controller/marca_controller.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/controller/subcategoria_controller.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/controller/tamanho_controller.dart';
import 'package:nosso/src/core/model/arquivo.dart';
import 'package:nosso/src/core/model/cor.dart';
import 'package:nosso/src/core/model/estoque.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/core/model/marca.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/core/model/tamanho.dart';
import 'package:nosso/src/core/model/uploadFileResponse.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/util/componentes/image_source_sheet.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/dropdown/dropdown_cor.dart';
import 'package:nosso/src/util/dropdown/dropdown_loja.dart';
import 'package:nosso/src/util/dropdown/dropdown_marca.dart';
import 'package:nosso/src/util/dropdown/dropdown_promocao.dart';
import 'package:nosso/src/util/dropdown/dropdown_subcategoria.dart';
import 'package:nosso/src/util/dropdown/dropdown_tamanho.dart';
import 'package:nosso/src/util/upload/upload_response.dart';
import 'package:nosso/src/util/validador/validador_produto.dart';

class ProdutoCreatePage extends StatefulWidget {
  Produto produto;

  ProdutoCreatePage({Key key, this.produto}) : super(key: key);

  @override
  _ProdutoCreatePageState createState() =>
      _ProdutoCreatePageState(p: this.produto);
}

class _ProdutoCreatePageState extends State<ProdutoCreatePage>
    with ValidadorProduto {
  _ProdutoCreatePageState({this.p});

  var produtoController = GetIt.I.get<ProdutoController>();
  var subCategoriaController = GetIt.I.get<SubCategoriaController>();
  var lojaController = GetIt.I.get<LojaController>();
  var marcaController = GetIt.I.get<MarcaController>();
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var tamanhoController = GetIt.I.get<TamanhoController>();
  var corController = GetIt.I.get<CorController>();

  Dialogs dialogs = Dialogs();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<SubCategoria>> subCategorias;
  Future<List<Marca>> marcas;
  Future<List<Promocao>> promocoes;
  Future<List<Loja>> lojas;
  List<Arquivo> arquivoSelecionados = List();

  Produto p;
  Estoque e;

  SubCategoria subCategoriaSelecionada;
  Loja lojaSelecionada;
  Promocao promocaoSelecionada;
  Marca marcaSelecionada;
  List<Cor> coreSelecionados;
  List<Tamanho> tamanhoSelecionados;

  Controller controller;
  var controllerCodigoBarra = TextEditingController();
  var controllerQuantidade = TextEditingController();
  var controllerValorUnitario = TextEditingController();
  var controllerDesconto = TextEditingController();
  var controllerPecentual = TextEditingController();
  var controllerValorVenda = TextEditingController();

  var uploadFileResponse = UploadFileResponse();
  var response = UploadRespnse();

  String barcode = "";
  bool novo;
  bool status;
  bool destaque;

  double desconto;
  double valor;
  int quantidade;

  String medida;
  String tamanho;
  String origem;
  String estoqueStatus;

  File file;

  @override
  void initState() {
    if (p == null) {
      p = Produto();
      e = Estoque();

      novo = false;
      status = false;
      destaque = false;

      medida = "UNIDADE";
      origem = "NACIONAL";
      estoqueStatus = "BAIXO";
    } else {
      novo = p.novo;
      status = p.status;
      destaque = p.destaque;

      e = p.estoque;

      lojaController.lojaSelecionada = p.loja;
      subCategoriaController.subCategoriaSelecionada = p.subCategoria;
      marcaController.marcaSelecionada = p.marca;
      promocaoController.promocaoSelecionada = p.promocao;
      // produtoController.corSelecionadas = p.cores;
      // produtoController.tamanhoSelecionados = p.tamanhos;

      controllerQuantidade.text = p.estoque.quantidade.toStringAsFixed(0);
      controllerValorUnitario.text = p.estoque.valorUnitario.toStringAsFixed(2);
      controllerValorVenda.text = p.estoque.valorVenda.toStringAsFixed(2);
      controllerPecentual.text = p.estoque.percentual.toStringAsFixed(2);
    }

    produtoController.getAll();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  executar(String nomeAudio) {}

  barcodeScanning() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        executar("beep-07");
        this.barcode = barcode;
        controllerCodigoBarra.text = this.barcode;
      });
    } on FormatException {
      setState(() => this.barcode = 'Nada capturado.');
    } catch (e) {
      setState(() => this.barcode = 'Erros: $e');
    }
  }

  bool isEnabledEnviar = false;
  bool isEnabledDelete = false;

  enableButton() {
    setState(() {
      isEnabledEnviar = true;
    });
  }

  disableButton() {
    setState(() {
      isEnabledDelete = true;
    });
  }

  onClickUpload() async {
    if (file != null) {
      var url = await promocaoController.upload(file, p.foto);

      print("url: ${url}");

      print("========= UPLOAD FILE RESPONSE ========= ");

      uploadFileResponse = response.response(uploadFileResponse, url);

      print("fileName: ${uploadFileResponse.fileName}");
      print("fileDownloadUri: ${uploadFileResponse.fileDownloadUri}");
      print("fileType: ${uploadFileResponse.fileType}");
      print("size: ${uploadFileResponse.size}");

      p.foto = uploadFileResponse.fileName;

      setState(() {
        uploadFileResponse;
      });

      showSnackbar(context, "Arquivo anexada com sucesso!");
    }
  }

  showToast(String cardTitle) {
    Fluttertoast.showToast(
      msg: "$cardTitle",
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 10,
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

  calcularValorVenda() {
    double valor = (double.tryParse(controllerValorUnitario.text) *
            double.tryParse(controllerPecentual.text)) /
        100;
    controllerValorVenda.text = valor.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: p.nome == null ? Text("Cadastro de produtos") : Text(p.nome),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 100, right: 100, top: 10),
        child: Observer(
          builder: (context) {
            if (produtoController.dioError == null) {
              return buildListViewForm(context);
            } else {
              print("Erro: ${produtoController.mensagem}");
              showToast("${produtoController.mensagem}");
              return buildListViewForm(context);
            }
          },
        ),
      ),
    );
  }

  buildListViewForm(BuildContext context) {
    var focus = FocusScope.of(context);
    var dateFormat = DateFormat('dd/MM/yyyy');
    var formatter = NumberFormat("00.00");
    var formata = new NumberFormat("#,##0.00", "pt_BR");
    p.estoque = e;

    return ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 350,
                  color: Colors.grey[400],
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => ImageSourceSheet(
                          onImageSelected: (image) {
                            setState(() {
                              Navigator.of(context).pop();
                              file = image;
                              String arquivo = file.path.split('/').last;
                              print("Image: ${arquivo}");
                              enableButton();
                            });
                          },
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.grey[600],
                      padding: EdgeInsets.all(5),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            file != null
                                ? Image.file(
                                    file,
                                    fit: BoxFit.fitWidth,
                                    width: double.infinity,
                                    height: 340,
                                  )
                                : p.foto != null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                          produtoController.arquivo + p.foto,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                        ),
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.grey[300],
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RaisedButton(
                              child: Icon(Icons.delete_forever),
                              shape: new CircleBorder(),
                              onPressed: isEnabledDelete
                                  ? () => produtoController.deleteFoto(p.foto)
                                  : null,
                            ),
                            RaisedButton(
                              child: Icon(Icons.photo),
                              shape: new CircleBorder(),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => ImageSourceSheet(
                                    onImageSelected: (image) {
                                      setState(() {
                                        Navigator.of(context).pop();
                                        file = image;
                                        String arquivo =
                                            file.path.split('/').last;
                                        print("Image: ${arquivo}");
                                        enableButton();
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                            RaisedButton(
                              child: Icon(Icons.check),
                              shape: new CircleBorder(),
                              onPressed: isEnabledEnviar
                                  ? () => onClickUpload()
                                  : null,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Text("Descrição"),
                  children: [
                    uploadFileResponse.fileName != null
                        ? Container(
                            height: 400,
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: ListTile(
                                    title: Text("fileName"),
                                    subtitle:
                                        Text("${uploadFileResponse.fileName}"),
                                  ),
                                ),
                                Container(
                                  child: ListTile(
                                    title: Text("fileDownloadUri"),
                                    subtitle: Text(
                                        "${uploadFileResponse.fileDownloadUri}"),
                                  ),
                                ),
                                Container(
                                  child: ListTile(
                                    title: Text("fileType"),
                                    subtitle:
                                        Text("${uploadFileResponse.fileType}"),
                                  ),
                                ),
                                Container(
                                  child: ListTile(
                                    title: Text("size"),
                                    subtitle:
                                        Text("${uploadFileResponse.size}"),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(15),
                            child: Text("Deve anexar uma foto"),
                            alignment: Alignment.bottomLeft,
                          ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        initialValue: p.codigoBarra,
                        controller: p.codigoBarra == null
                            ? controllerCodigoBarra
                            : null,
                        onSaved: (value) => p.codigoBarra = value,
                        validator: validateCodigoBarra,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => controllerCodigoBarra.clear(),
                            icon: Icon(Icons.clear),
                          ),
                          labelText:
                              "Entre com código de barra ou clique (scanner)",
                          hintText: "Código de barra",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 20,
                      ),
                      SizedBox(height: 10),
                      RaisedButton.icon(
                        elevation: 0.0,
                        icon: Icon(Icons.photo_camera_outlined),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                          side: BorderSide(color: Colors.transparent),
                        ),
                        label: Text("Scanner"),
                        onPressed: () {
                          barcodeScanning();
                        },
                      ),
                    ],
                  ),
                ),
                /* ================ Cadastro produto ================ */
                SizedBox(height: 0),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: p.nome,
                        onSaved: (value) => p.nome = value,
                        validator: validateNome,
                        decoration: InputDecoration(
                          labelText: "Nome",
                          hintText: "nome produto",
                          prefixIcon: Icon(
                            Icons.shopping_cart,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        maxLines: null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: p.descricao,
                        onSaved: (value) => p.descricao = value,
                        validator: validateDescricao,
                        decoration: InputDecoration(
                          labelText: "Descrição",
                          hintText: "descrição produto",
                          prefixIcon: Icon(
                            Icons.description,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        maxLines: null,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: p.sku,
                        onSaved: (value) => p.sku = value,
                        validator: validateSKU,
                        decoration: InputDecoration(
                          labelText: "SKU",
                          hintText: "sku produto",
                          prefixIcon: Icon(
                            Icons.shopping_cart,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 100,
                        maxLines: 1,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controllerQuantidade,
                        onSaved: (value) {
                          p.estoque.quantidade = int.tryParse(value);
                        },
                        validator: validateQuantidade,
                        decoration: InputDecoration(
                          labelText: "Quantidade de estoque",
                          hintText: "Entre com a quantidade",
                          prefixIcon: Icon(
                            Icons.mode_edit,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(Icons.close),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: false),
                        maxLength: 6,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controllerValorUnitario,
                        onSaved: (value) {
                          p.estoque.valorUnitario = double.tryParse(value);
                        },
                        validator: validateValorUnitario,
                        decoration: InputDecoration(
                          labelText: "Valor unitário",
                          hintText: "Valor unitário",
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => controllerValorUnitario.clear(),
                            icon: Icon(Icons.clear),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLength: 10,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controllerPecentual,
                        onSaved: (value) {
                          p.estoque.percentual = double.tryParse(value);
                        },
                        validator: validatePercentual,
                        onChanged: (percentual) {
                          valor = (double.tryParse(
                                  controllerValorUnitario.text) +
                              (double.tryParse(controllerValorUnitario.text) *
                                      double.tryParse(
                                          controllerPecentual.text)) /
                                  100);
                          controllerValorVenda.text = valor.toStringAsFixed(2);
                        },
                        decoration: InputDecoration(
                          labelText: "Percentual de ganho",
                          hintText: "Percentual de ganho",
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => controllerPecentual.clear(),
                            icon: Icon(Icons.clear),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLength: 10,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: controllerValorVenda,
                        onSaved: (value) {
                          p.estoque.valorVenda = double.tryParse(value);
                        },
                        validator: validateValorVenda,
                        decoration: InputDecoration(
                          labelText: "Valor de venda",
                          hintText: "Valor de venda",
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => controllerValorVenda.clear(),
                            icon: Icon(Icons.clear),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple[900]),
                            gapPadding: 1,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLength: 10,
                        enabled: false,
                      ),
                      SizedBox(height: 10),
                      // DateTimeField(
                      //   initialValue: p.estoque.dataRegistro,
                      //   format: dateFormat,
                      //   validator: validateDateRegistro,
                      //   onSaved: (value) => p.estoque.dataRegistro = value,
                      //   decoration: InputDecoration(
                      //     labelText: "Data registro",
                      //     hintText: "99-09-9999",
                      //     prefixIcon: Icon(
                      //       Icons.calendar_today,
                      //       color: Colors.grey,
                      //     ),
                      //     suffixIcon: Icon(Icons.close),
                      //     contentPadding:
                      //         EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(5.0)),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.purple[900]),
                      //       gapPadding: 1,
                      //       borderRadius: BorderRadius.circular(5.0),
                      //     ),
                      //   ),
                      //   onEditingComplete: () => focus.nextFocus(),
                      //   onShowPicker: (context, currentValue) {
                      //     return showDatePicker(
                      //       context: context,
                      //       firstDate: DateTime(2000),
                      //       initialDate: currentValue ?? DateTime.now(),
                      //       locale: Locale('pt', 'BR'),
                      //       lastDate: DateTime(2030),
                      //     );
                      //   },
                      //   maxLength: 10,
                      // ),
                      SizedBox(height: 10),
                      // DateTimeField(
                      //   initialValue: p.estoque.dataVencimento,
                      //   format: dateFormat,
                      //   validator: validateDateVencimento,
                      //   onSaved: (value) => p.estoque.dataVencimento = value,
                      //   decoration: InputDecoration(
                      //     labelText: "Data vencimento",
                      //     hintText: "99-09-9999",
                      //     prefixIcon: Icon(
                      //       Icons.calendar_today,
                      //       color: Colors.grey,
                      //     ),
                      //     suffixIcon: Icon(Icons.close),
                      //     contentPadding:
                      //     EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(5.0)),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: Colors.purple[900]),
                      //       gapPadding: 1,
                      //       borderRadius: BorderRadius.circular(5.0),
                      //     ),
                      //   ),
                      //   onEditingComplete: () => focus.nextFocus(),
                      //   onShowPicker: (context, currentValue) {
                      //     return showDatePicker(
                      //       context: context,
                      //       firstDate: DateTime(2000),
                      //       initialDate: currentValue ?? DateTime.now(),
                      //       locale: Locale('pt', 'BR'),
                      //       lastDate: DateTime(2030),
                      //     );
                      //   },
                      //   maxLength: 10,
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropDownMarca(),
                    Observer(
                      builder: (context) {
                        if (marcaController.marcaSelecionada == null) {
                          return Container(
                            padding: EdgeInsets.only(left: 25),
                            child: Container(
                              child: marcaController.mensagem == null
                                  ? Text(
                                      "Campo obrigatório *",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      "${marcaController.mensagem}",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          );
                        }
                        return Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Container(
                            child:
                                Icon(Icons.check_outlined, color: Colors.green),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    DropDownSubCategoria(subCategoriaSelecionada),
                    Observer(
                      builder: (context) {
                        if (subCategoriaController.subCategoriaSelecionada ==
                            null) {
                          return Container(
                            padding: EdgeInsets.only(left: 25),
                            child: Container(
                              child: subCategoriaController.mensagem == null
                                  ? Text(
                                      "campo obrigatório *",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      "${subCategoriaController.mensagem}",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          );
                        }
                        return Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Container(
                            child:
                                Icon(Icons.check_outlined, color: Colors.green),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    DropDownLoja(lojaSelecionada),
                    Observer(
                      builder: (context) {
                        if (lojaController.lojaSelecionada == null) {
                          return Container(
                            padding: EdgeInsets.only(left: 25),
                            child: Container(
                              child: lojaController.mensagem == null
                                  ? Text(
                                      "campo obrigatório *",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      "${lojaController.mensagem}",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          );
                        }
                        return Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Container(
                            child:
                                Icon(Icons.check_outlined, color: Colors.green),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    DropDownPromocao(promocaoSelecionada),
                    Observer(
                      builder: (context) {
                        if (promocaoController.promocaoSelecionada == null) {
                          return Container(
                            padding: EdgeInsets.only(left: 25),
                            child: Container(
                              child: promocaoController.mensagem == null
                                  ? Text(
                                      "campo obrigatório *",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      "${promocaoController.mensagem}",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                            ),
                          );
                        }
                        return Container(
                          padding: EdgeInsets.only(left: 25),
                          child: Container(
                            child:
                                Icon(Icons.check_outlined, color: Colors.green),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    DropDownCor(coreSelecionados),
                    SizedBox(height: 10),
                    DropDownTamanho(tamanhoSelecionados),
                    SizedBox(height: 10),
                  ],
                ),
                SizedBox(height: 0),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SwitchListTile(
                            autofocus: true,
                            title: Text("Produto novo? "),
                            subtitle: Text("sim/não"),
                            value: p.novo = novo,
                            secondary: const Icon(Icons.check_outlined),
                            onChanged: (bool valor) {
                              setState(() {
                                novo = valor;
                                print("Novo: " + p.novo.toString());
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SwitchListTile(
                            subtitle: Text("sim/não"),
                            title: Text("Produto Disponível?"),
                            value: p.status = status,
                            secondary: const Icon(Icons.check_outlined),
                            onChanged: (bool valor) {
                              setState(() {
                                status = valor;
                                print("Disponivel: " + p.status.toString());
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SwitchListTile(
                            autofocus: true,
                            subtitle: Text("sim/não"),
                            title: Text("Produto destaque?"),
                            value: p.destaque = destaque,
                            secondary: const Icon(Icons.check_outlined),
                            onChanged: (bool valor) {
                              setState(() {
                                destaque = valor;
                                print("Destaque: " + p.destaque.toString());
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Unidade de medida"),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("UNIDADE"),
                              value: "UNIDADE",
                              groupValue: p.medida == null
                                  ? p.medida = medida
                                  : p.medida,
                              secondary: const Icon(Icons.check_outlined),
                              onChanged: (String valor) {
                                setState(() {
                                  p.medida = valor;
                                  print("Medida: " + p.medida);
                                });
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("PEÇA"),
                              value: "PECA",
                              groupValue: p.medida == null
                                  ? p.medida = medida
                                  : p.medida,
                              secondary: const Icon(Icons.check_outlined),
                              onChanged: (String valor) {
                                setState(() {
                                  p.medida = valor;
                                  print("Medida: " + p.medida);
                                });
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("QUILOGRAMA"),
                              value: "QUILOGRAMA",
                              groupValue: p.medida == null
                                  ? p.medida = medida
                                  : p.medida,
                              secondary: const Icon(Icons.check_outlined),
                              onChanged: (String valor) {
                                setState(() {
                                  p.medida = valor;
                                  print("resultado: " + p.medida);
                                });
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("OUTRO"),
                              value: "OUTRO",
                              groupValue: p.medida == null
                                  ? p.medida = medida
                                  : p.medida,
                              secondary: const Icon(Icons.check_outlined),
                              onChanged: (String valor) {
                                setState(() {
                                  p.medida = valor;
                                  print("resultado: " + p.medida);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Origem do produto"),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("NACIONAL"),
                              value: "NACIONAL",
                              groupValue: p.origem == null
                                  ? p.origem = origem
                                  : p.origem,
                              secondary: const Icon(Icons.check_outlined),
                              onChanged: (String valor) {
                                setState(() {
                                  p.origem = valor;
                                  print("Origem: " + p.origem);
                                });
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text("INTERNACIONAL"),
                              value: "INTERNACIONAL",
                              groupValue: p.origem == null
                                  ? p.origem = origem
                                  : p.origem,
                              secondary: const Icon(Icons.check_outlined),
                              onChanged: (String valor) {
                                setState(() {
                                  p.origem = valor;
                                  print("Origem: " + p.origem);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 0),
        Container(
          padding: EdgeInsets.all(15),
          child: RaisedButton.icon(
              label: Text("Enviar formulário"),
              icon: Icon(Icons.check),
              onPressed: () {
                if (controller.validate()) {
                  if (p.id == null) {
                    dialogs.information(context, "prepando para o cadastro...");
                    Timer(Duration(seconds: 3), () {
                      DateTime agora = DateTime.now();

                      p.estoque.estoqueStatus = estoqueStatus;
                      p.loja = lojaController.lojaSelecionada;
                      p.subCategoria =
                          subCategoriaController.subCategoriaSelecionada;
                      p.marca = marcaController.marcaSelecionada;
                      p.promocao = promocaoController.promocaoSelecionada;
                      // p.tamanhos = produtoController.tamanhoSelecionados;
                      // p.cores = produtoController.corSelecionadas;

                      print("Loja: ${p.loja.nome}");
                      print("SubCategoria: ${p.subCategoria.nome}");
                      print("Marca: ${p.marca.nome}");
                      print("Promoção: ${p.promocao.nome}");

                      print("Foto: ${p.foto}");
                      print("Código de Barra: ${p.codigoBarra}");
                      print("Produto: ${p.nome}");
                      print("Descrição: ${p.descricao}");
                      print("Quantidade: ${p.estoque.quantidade}");
                      print("Estoque Status: ${p.estoque.estoqueStatus}");
                      print("Valor: ${p.estoque.valorUnitario}");

                      print("Novo: ${p.novo}");
                      print("Status: ${p.status}");
                      print("Destaque: ${p.destaque}");

                      print("Medida: ${p.medida}");
                      print("Origem: ${p.origem}");

                      // print("Registro: ${p.estoque.dataRegistro}");
                      // print("Vencimento: ${p.estoque.dataVencimento}");
                      print("Agora: ${agora}");

                      for (Cor c in corController.cores) {
                        print("Cores: ${c.descricao}");
                      }

                      for (Tamanho c in tamanhoController.tamanhos) {
                        print("Tamanhos: ${c.descricao}");
                      }

                      p.cores.addAll(produtoController.corSelecionadas);
                      p.tamanhos.addAll(produtoController.tamanhoSelecionados);

                      p.estoque.quantidade =
                          int.tryParse(controllerQuantidade.text);
                      p.estoque.valorUnitario =
                          double.tryParse(controllerValorUnitario.text);
                      p.estoque.valorVenda =
                          double.tryParse(controllerValorVenda.text);
                      p.estoque.percentual =
                          double.tryParse(controllerPecentual.text);

                      produtoController.create(p).then((value) {
                        print("resultado : ${value}");
                      });
                      Navigator.of(context).pop();
                      buildPush(context);
                    });
                  } else {
                    dialogs.information(
                        context, "preparando para o alteração...");
                    Timer(Duration(seconds: 3), () {
                      DateTime agora = DateTime.now();

                      print("Loja: ${p.loja.nome}");
                      print("SubCategoria: ${p.subCategoria.nome}");
                      print("Marca: ${p.marca.nome}");
                      print("Promoção: ${p.promocao.nome}");

                      print("Foto: ${p.foto}");
                      print("Código de Barra: ${p.codigoBarra}");
                      print("Produto: ${p.nome}");
                      print("Descrição: ${p.descricao}");
                      print("Quantidade: ${p.estoque.quantidade}");
                      print("Valor: ${p.estoque.valorUnitario}");

                      print("Novo: ${p.novo}");
                      print("Status: ${p.status}");
                      print("Destaque: ${p.destaque}");

                      print("Medida: ${p.medida}");
                      print("Origem: ${p.origem}");

                      // print("Registro: ${p.estoque.dataRegistro}");
                      // print("Vencimento: ${p.estoque.dataVencimento}");
                      print("Agora: ${agora}");

                      // for (Cor c in produtoController.corSelecionadas) {
                      //   print("Cores: ${c.descricao}");
                      // }
                      //
                      // for (Tamanho c in produtoController.tamanhoSelecionados) {
                      //   print("Tamanhos: ${c.descricao}");
                      // }
                      //
                      // p.cores.addAll(produtoController.corSelecionadas);
                      // p.tamanhos.addAll(produtoController.tamanhoSelecionados);

                      p.estoque.quantidade =
                          int.tryParse(controllerQuantidade.text);
                      p.estoque.valorUnitario =
                          double.tryParse(controllerValorUnitario.text);
                      p.estoque.valorVenda =
                          double.tryParse(controllerValorVenda.text);
                      p.estoque.percentual =
                          double.tryParse(controllerPecentual.text);

                      produtoController.update(p.id, p);
                      Navigator.of(context).pop();
                      buildPush(context);
                    });
                  }
                }
              }),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  buildPush(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProdutoTab(),
      ),
    );
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
