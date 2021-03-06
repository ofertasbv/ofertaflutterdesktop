import 'dart:async';
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/cor_controller.dart';
import 'package:nosso/src/core/controller/marca_controller.dart';
import 'package:nosso/src/core/controller/medida_controller.dart';
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
import 'package:nosso/src/core/model/medida.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/core/model/subcategoria.dart';
import 'package:nosso/src/core/model/tamanho.dart';
import 'package:nosso/src/core/model/uploadFileResponse.dart';
import 'package:nosso/src/paginas/produto/produto_table.dart';
import 'package:nosso/src/util/componentes/image_source_sheet.dart';
import 'package:nosso/src/util/dialogs/dialogs.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
import 'package:nosso/src/util/upload/upload_response.dart';
import 'package:nosso/src/util/validador/validador_produto.dart';
import 'package:search_choices/search_choices.dart';

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
  var medidaController = GetIt.I.get<MedidaController>();

  Dialogs dialogs = Dialogs();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<SubCategoria>> subCategorias;
  Future<List<Marca>> marcas;
  Future<List<Promocao>> promocoes;
  Future<List<Loja>> lojas;
  List<Arquivo> arquivoSelecionados = List();

  Produto p;
  Estoque e;

  Medida medidaSelecionada;
  SubCategoria subCategoriaSelecionada;
  Loja lojaSelecionada;
  Promocao promocaoSelecionada;
  Marca marcaSelecionada;
  List<Cor> coreSelecionados;
  List<Tamanho> tamanhoSelecionados;
  List<Cor> coresSelecionadas = [];
  List<int> tamanhosSelecionados = [];

  String corSelecionda;

  Controller controller;
  var controllerCodigoBarra = TextEditingController();
  var controllerQuantidade = TextEditingController();

  var controllerValorUnit = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
    precision: 2,
  );
  var controllerDesconto = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
    precision: 2,
  );
  var controllerPecentual = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
    precision: 2,
  );
  var controllerValorVenda = MoneyMaskedTextController(
    decimalSeparator: ",",
    thousandSeparator: ".",
    initialValue: 0.00,
    precision: 2,
  );

  var uploadFileResponse = UploadFileResponse();
  var response = UploadRespnse();

  String barcode = "";
  bool novo;
  bool status;
  bool destaque;

  double desconto;
  double valor;
  int quantidade;
  String tamanho;
  File file;

  @override
  void initState() {
    if (p == null) {
      p = Produto();
      e = Estoque();

      novo = false;
      status = false;
      destaque = false;
    } else {
      novo = p.novo;
      status = p.status;
      destaque = p.destaque;

      e = p.estoque;
      marcaSelecionada = p.marca;
      medidaSelecionada = p.medida;
      subCategoriaSelecionada = p.subCategoria;
      lojaSelecionada = p.loja;
      promocaoSelecionada = p.promocao;

      controllerQuantidade.text = p.estoque.quantidade.toStringAsFixed(0);
      controllerValorUnit.text = p.estoque.valorUnitario.toStringAsFixed(2);
      controllerValorVenda.text = p.estoque.valorVenda.toStringAsFixed(2);
      controllerPecentual.text = p.estoque.percentual.toStringAsFixed(2);
    }

    tamanhoController.getAll();
    corController.getAll();
    marcaController.getAll();
    subCategoriaController.getAll();
    lojaController.getAll();
    promocaoController.getAll();
    produtoController.getAll();
    medidaController.getAll();
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
    double valor = (double.tryParse(controllerValorUnit.text) *
            double.tryParse(controllerPecentual.text)) /
        100;
    controllerValorVenda.text = valor.toStringAsFixed(2);
  }

  buscarByCodigoDeBarra(String codigoBarra) async {
    p = await produtoController.getCodigoBarra(codigoBarra);
    if (p != null) {
      showSnackbar(context, "${p.nome}");
      print("produto: ${p.nome}");
    } else {
      showSnackbar(context, "produto n??o encontrado!");
    }
  }

  // builderConteudoListCores2() {
  //   return Container(
  //     color: Colors.grey[200],
  //     padding: EdgeInsets.only(top: 0),
  //     child: Observer(
  //       builder: (context) {
  //         List<Cor> cores = corController.cores;
  //         if (corController.error != null) {
  //           return Text("N??o foi poss??vel carregados dados");
  //         }
  //
  //         if (cores == null) {
  //           return CircularProgressorMini();
  //         }
  //
  //         return customSearchableDropDown(
  //           items: cores,
  //           label: 'Selecione uma cor',
  //           multiSelectTag: 'cores',
  //           multiSelectValuesAsWidget: true,
  //           decoration: BoxDecoration(border: Border.all(color: Colors.black)),
  //           multiSelect: true,
  //           prefixIcon: Padding(
  //             padding: const EdgeInsets.all(8),
  //             child: Icon(Icons.search),
  //           ),
  //
  //           dropDownMenuItems: cores.map((e) {
  //             return e.descricao;
  //           }).toList(),
  //           onChanged: (value) {
  //             coresSelecionadas = value;
  //             print("Cores selecionadas index: ${coresSelecionadas}");
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  builderConteudoListCores() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Cor> cores = corController.cores;
          if (corController.error != null) {
            return Text("N??o foi poss??vel carregados dados");
          }

          if (cores == null) {
            return CircularProgressorMini();
          }

          return SearchChoices<Cor>.multiple(
            items: cores.map((c) {
              return DropdownMenuItem<Cor>(
                child: Text(c.descricao),
                value: c,
                onTap: () {
                  coreSelecionados.add(c);
                  print("Cores selecionadas onTap: ${coreSelecionados}");
                },
              );
            }).toList(),
            // selectedItems: coresSelecionadas,
            hint: "Selecione uma cor",
            searchHint: "Selecione uma cor",
            validator: (value) => value == null ? "campo obrigat??rio" : null,
            onChanged: (value) {
              setState(() {
                coresSelecionadas = value;
                // coreSelecionados.insertAll(value, coresSelecionadas);
                // p.cores.addAll(Iterable<Cor>.generate(coreSelecionados.length).toList());
                // coreSelecionados.addAll(Iterable<Cor>.generate(coreSelecionados.length).toList());
                print("Cores selecionadas index: ${coresSelecionadas}");
                print("Cores selecionadas objeto: ${cores[0].toString()}");
              });
            },
            isExpanded: true,
            padding: 20,
            selectedAggregateWidgetFn: (List<Widget> list) {
              return (Column(children: [
                Text("${list.length} cores selecionadas"),
                Wrap(children: list),
              ]));
            },
          );
        },
      ),
    );
  }

  builderConteudoLisTamanhos() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Tamanho> tamanhos = tamanhoController.tamanhos;
          if (tamanhoController.error != null) {
            return Text("N??o foi poss??vel carregados dados");
          }

          if (tamanhos == null) {
            return CircularProgressorMini();
          }

          return SearchChoices<Tamanho>.multiple(
            items: tamanhos.map((e) {
              return DropdownMenuItem<Tamanho>(
                child: Text(e.descricao),
                value: e,
              );
            }).toList(),
            selectedItems: tamanhosSelecionados,
            hint: "Selecione um tamanho",
            searchHint: "Selecione uma cor",
            validator: (value) => value == null ? "campo obrigat??rio" : null,
            onChanged: (value) {
              setState(() {
                tamanhosSelecionados = value;
              });
            },
            isExpanded: true,
            padding: 20,
            selectedAggregateWidgetFn: (List<Widget> list) {
              return (Column(children: [
                Text("${list.length} tamanhos selecionados"),
                Wrap(children: list),
              ]));
            },
          );
        },
      ),
    );
  }

  builderConteudoListLojas() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Loja> lojas = lojaController.lojas;
          if (lojaController.error != null) {
            return Text("N??o foi poss??vel carregados dados");
          }

          if (lojas == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Loja>(
            label: "Selecione lojas",
            popupTitle: Center(child: Text("Lojas")),
            items: lojas,
            showSearchBox: true,
            itemAsString: (Loja s) => s.nome,
            validator: (value) => value == null ? "campo obrigat??rio" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: lojaSelecionada,
            onChanged: (Loja l) {
              setState(() {
                p.loja = l;
                print("loja: ${p.loja.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por loja",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListPromocaoes() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Promocao> promocoes = promocaoController.promocoes;
          if (promocaoController.error != null) {
            return Text("N??o foi poss??vel carregados dados");
          }

          if (promocoes == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Promocao>(
            label: "Selecione promocoes",
            popupTitle: Center(child: Text("Promo????es")),
            items: promocoes,
            showSearchBox: true,
            itemAsString: (Promocao s) => s.nome,
            validator: (value) => value == null ? "campo obrigat??rio" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: promocaoSelecionada,
            onChanged: (Promocao s) {
              setState(() {
                p.promocao = s;
                print("promo????o: ${p.promocao.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por promo????o",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListMarcas() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Marca> marcas = marcaController.marcas;
          if (marcaController.error != null) {
            return Text("N??o foi poss??vel carregados dados");
          }

          if (marcas == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Marca>(
            label: "Selecione marcas",
            popupTitle: Center(child: Text("Marcas")),
            items: marcas,
            showSearchBox: true,
            itemAsString: (Marca s) => s.nome,
            validator: (value) => value == null ? "campo obrigat??rio" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: marcaSelecionada,
            onChanged: (Marca m) {
              setState(() {
                p.marca = m;
                print("marca: ${p.marca.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por marca",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListSubCategorias() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<SubCategoria> subcategorias =
              subCategoriaController.subCategorias;
          if (subCategoriaController.error != null) {
            return Text("N??o foi poss??vel carregados dados");
          }

          if (subcategorias == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<SubCategoria>(
            label: "Selecione categorias",
            popupTitle: Center(child: Text("Categorias")),
            items: subcategorias,
            showSearchBox: true,
            itemAsString: (SubCategoria s) => s.nome,
            validator: (value) => value == null ? "campo obrigat??rio" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: subCategoriaSelecionada,
            onChanged: (SubCategoria s) {
              setState(() {
                p.subCategoria = s;
                print("SubCategoria: ${p.subCategoria.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por categoria",
            ),
          );
        },
      ),
    );
  }

  builderConteudoListMedidas() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Medida> medidas = medidaController.medidas;
          if (medidaController.error != null) {
            return Text("N??o foi poss??vel carregados dados");
          }

          if (medidas == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Medida>(
            label: "Selecione medidas",
            popupTitle: Center(child: Text("Medidas")),
            items: medidas,
            showSearchBox: true,
            itemAsString: (Medida s) => s.descricao,
            validator: (value) => value == null ? "campo obrigat??rio" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: medidaSelecionada,
            onChanged: (Medida s) {
              setState(() {
                p.medida = s;
                print("Medida: ${p.medida.descricao}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por medida",
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: p.nome == null ? Text("Cadastro de produtos") : Text(p.nome),
      ),
      body: Scrollbar(
        child: Container(
          padding: EdgeInsets.only(left: 100, right: 100, top: 10),
          child: Card(
            child: Observer(
              builder: (context) {
                if (produtoController.dioError == null) {
                  return buildListViewForm(context);
                } else {
                  print("Erro: ${produtoController.mensagem}");
                  return buildListViewForm(context);
                }
              },
            ),
          ),
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
                  height: 150,
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
                  title: Text("Descri????o"),
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
                              "Entre com c??digo de barra ou clique (scanner)",
                          hintText: "C??digo de barra",
                        ),
                        onEditingComplete: () => focus.nextFocus(),
                        keyboardType: TextInputType.text,
                        maxLength: 20,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton.icon(
                            elevation: 0.0,
                            icon: Icon(Icons.clear),
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30),
                              side: BorderSide(color: Colors.transparent),
                            ),
                            label: Text("limpar"),
                            onPressed: () {
                              controllerCodigoBarra.clear();
                              p = new Produto();
                            },
                          ),
                          RaisedButton.icon(
                            elevation: 0.0,
                            icon: Icon(Icons.photo_camera_outlined),
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30),
                              side: BorderSide(color: Colors.transparent),
                            ),
                            label: Text("buscar"),
                            onPressed: () {
                              buscarByCodigoDeBarra(controllerCodigoBarra.text);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        child: TextFormField(
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
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          maxLength: 100,
                          maxLines: null,
                        ),
                      ),
                      Container(
                        width: 500,
                        child: TextFormField(
                          initialValue: p.descricao,
                          onSaved: (value) => p.descricao = value,
                          validator: validateDescricao,
                          decoration: InputDecoration(
                            labelText: "Descri????o",
                            hintText: "descri????o produto",
                            prefixIcon: Icon(
                              Icons.description,
                              color: Colors.grey,
                            ),
                            suffixIcon: Icon(Icons.close),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          keyboardType: TextInputType.text,
                          maxLength: 100,
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),

                /* ================ Cadastro produto ================ */
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(0),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 500,
                              child: TextFormField(
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
                                ),
                                onEditingComplete: () => focus.nextFocus(),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                                maxLength: 6,
                              ),
                            ),
                            Container(
                              width: 500,
                              child: TextFormField(
                                controller: controllerValorUnit,
                                decoration: InputDecoration(
                                    labelText: 'Valor Unit??rio'),
                                onChanged: (value) {
                                  value = controllerValorUnit.text;
                                  print("Valor Unit??rio: ${value}");
                                },
                                onSaved: (value) {
                                  controllerValorUnit.updateValue(valor);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(0),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 500,
                              child: TextFormField(
                                controller: controllerPecentual,
                                decoration: InputDecoration(
                                    labelText: 'Percentual de venda'),
                                onChanged: (value) {
                                  value = controllerPecentual.text;
                                  print("Percentual de venda: ${value}");
                                },
                                onSaved: (value) {
                                  controllerPecentual.updateValue(valor);
                                },
                              ),
                            ),
                            Container(
                              width: 500,
                              child: TextFormField(
                                controller: controllerValorVenda,
                                decoration: InputDecoration(
                                    labelText: 'Valor de venda '),
                                onChanged: (value) {
                                  value = controllerValorVenda.text;
                                  print("Valor de venda: ${value}");
                                },
                                onSaved: (value) {
                                  controllerValorVenda.updateValue(valor);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        child: DateTimeField(
                          initialValue: p.estoque.dataFabricacao != null
                              ? p.estoque.dataFabricacao
                              : DateTime.now(),
                          format: dateFormat,
                          validator: validateDateFabricacao,
                          onSaved: (value) => p.estoque.dataFabricacao = value,
                          decoration: InputDecoration(
                            labelText: "Data fabrica????o",
                            hintText: "99-09-9999",
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                            suffixIcon: Icon(Icons.close),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              initialDate: currentValue ?? DateTime.now(),
                              locale: Locale('pt', 'BR'),
                              lastDate: DateTime(2030),
                            );
                          },
                          maxLength: 10,
                        ),
                      ),
                      Container(
                        width: 500,
                        child: DateTimeField(
                          initialValue: p.estoque.dataVencimento != null
                              ? p.estoque.dataVencimento
                              : DateTime.now(),
                          format: dateFormat,
                          validator: validateDateVencimento,
                          onSaved: (value) => p.estoque.dataVencimento = value,
                          decoration: InputDecoration(
                            labelText: "Data vencimento",
                            hintText: "99-09-9999",
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                            suffixIcon: Icon(Icons.close),
                          ),
                          onEditingComplete: () => focus.nextFocus(),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              initialDate: currentValue ?? DateTime.now(),
                              locale: Locale('pt', 'BR'),
                              lastDate: DateTime(2030),
                            );
                          },
                          maxLength: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListLojas(),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListPromocaoes(),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListSubCategorias(),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListMarcas(),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListMedidas(),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoLisTamanhos(),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoListCores(),
                      ),
                      Container(
                        width: 500,
                        color: Colors.grey[200],
                        child: builderConteudoLisTamanhos(),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 300,
                        color: Colors.grey[200],
                        child: SwitchListTile(
                          autofocus: true,
                          title: Text("Produto novo? "),
                          subtitle: Text("sim/n??o"),
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
                      Container(
                        width: 300,
                        color: Colors.grey[200],
                        child: SwitchListTile(
                          subtitle: Text("sim/n??o"),
                          title: Text("Produto Dispon??vel?"),
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
                      Container(
                        width: 300,
                        color: Colors.grey[200],
                        child: SwitchListTile(
                          autofocus: true,
                          subtitle: Text("sim/n??o"),
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
                      )
                    ],
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
              label: Text("Enviar formul??rio"),
              icon: Icon(Icons.check),
              onPressed: () {
                if (controller.validate()) {
                  if (p.id == null) {
                    dialogs.information(context, "prepando para o cadastro...");
                    Timer(Duration(seconds: 3), () {
                      DateTime agora = DateTime.now();
                      p.estoque.dataRegistro = agora;

                      // for (Cor c in corController.cores) {
                      //   print("Cores: ${c.descricao}");
                      // }
                      //
                      // for (Tamanho c in tamanhoController.tamanhos) {
                      //   print("Tamanhos: ${c.descricao}");
                      // }
                      //
                      // p.cores.addAll(produtoController.corSelecionadas);
                      // p.tamanhos.addAll(produtoController.tamanhoSelecionados);

                      print("Loja: ${p.loja.nome}");
                      print("SubCategoria: ${p.subCategoria.nome}");
                      print("Marca: ${p.marca.nome}");
                      print("Promo????o: ${p.promocao.nome}");

                      print("Foto: ${p.foto}");
                      print("C??digo de Barra: ${p.codigoBarra}");
                      print("Produto: ${p.nome}");
                      print("Descri????o: ${p.descricao}");
                      print("Quantidade: ${p.estoque.quantidade}");
                      print("Estoque Status: ${p.estoque.estoqueStatus}");
                      print("Valor unit??rio: ${p.estoque.valorUnitario}");
                      print("Percentual de ganho: ${p.estoque.percentual}");
                      print("Valor de venda: ${p.estoque.valorVenda}");

                      print("Novo: ${p.novo}");
                      print("Status: ${p.status}");
                      print("Destaque: ${p.destaque}");
                      print("Medida: ${p.medida.descricao}");

                      print("Registro: ${p.estoque.dataRegistro}");
                      print("Vencimento: ${p.estoque.dataVencimento}");
                      // for (Cor c in coreSelecionados) {
                      //   print("Cores: ${c.descricao}");
                      // }
                      //
                      // for (Tamanho c in tamanhoSelecionados) {
                      //   print("Tamanhos: ${c.descricao}");
                      // }
                      //
                      // p.cores.addAll(coreSelecionados);
                      // p.tamanhos.addAll(tamanhoSelecionados);

                      p.estoque.quantidade =
                          int.tryParse(controllerQuantidade.text);
                      p.estoque.valorUnitario =
                          double.tryParse(controllerValorUnit.text);
                      p.estoque.valorVenda =
                          double.tryParse(controllerValorVenda.text);
                      p.estoque.percentual =
                          double.tryParse(controllerPecentual.text);

                      // produtoController.create(p).then((value) {
                      //   print("resultado : ${value}");
                      // });
                      Navigator.of(context).pop();
                      // buildPush(context);
                    });
                  } else {
                    dialogs.information(
                        context, "preparando para o altera????o...");
                    Timer(Duration(seconds: 3), () {
                      DateTime agora = DateTime.now();

                      print("Loja: ${p.loja.nome}");
                      print("SubCategoria: ${p.subCategoria.nome}");
                      print("Marca: ${p.marca.nome}");
                      print("Promo????o: ${p.promocao.nome}");

                      print("Foto: ${p.foto}");
                      print("C??digo de Barra: ${p.codigoBarra}");
                      print("Produto: ${p.nome}");
                      print("Descri????o: ${p.descricao}");
                      print("Quantidade: ${p.estoque.quantidade}");
                      print("Valor unit??rio: ${p.estoque.valorUnitario}");
                      print("Percentual de ganho: ${p.estoque.percentual}");
                      print("Valor de venda: ${p.estoque.valorVenda}");

                      print("Novo: ${p.novo}");
                      print("Status: ${p.status}");
                      print("Destaque: ${p.destaque}");

                      print("Medida: ${p.medida.descricao}");
                      print("Registro: ${p.estoque.dataRegistro}");
                      print("Vencimento: ${p.estoque.dataVencimento}");

                      // for (Cor c in coreSelecionados) {
                      //   print("Cores: ${c.descricao}");
                      // }
                      //
                      // for (Tamanho c in tamanhoSelecionados) {
                      //   print("Tamanhos: ${c.descricao}");
                      // }
                      //
                      // p.cores.addAll(coreSelecionados);
                      // p.tamanhos.addAll(tamanhoSelecionados);

                      p.estoque.quantidade =
                          int.tryParse(controllerQuantidade.text);
                      p.estoque.valorUnitario =
                          double.tryParse(controllerValorUnit.text);
                      p.estoque.valorVenda =
                          double.tryParse(controllerValorVenda.text);
                      p.estoque.percentual =
                          double.tryParse(controllerPecentual.text);

                      // produtoController.update(p.id, p).then((value) {
                      //   print("resultado : ${value}");
                      // });
                      Navigator.of(context).pop();
                      // buildPush(context);
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
        builder: (context) => ProdutoTable(),
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
