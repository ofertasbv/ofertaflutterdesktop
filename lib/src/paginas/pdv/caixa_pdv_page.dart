import 'dart:ui';

// import 'package:audioplayers/audio_cache.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/pedido_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/caixafluxo.dart';
import 'package:nosso/src/core/model/pedido.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/pedido/pedido_create_page.dart';
import 'package:nosso/src/paginas/pedido/pedido_page.dart';
import 'package:nosso/src/paginas/pedidoitem/itens_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
import 'package:nosso/src/util/snackbar/snackbar_global.dart';
import 'package:nosso/src/util/validador/validador_pdv.dart';

class CaixaPDVPage extends StatefulWidget {
  CaixaFluxo caixa;

  CaixaPDVPage({Key key, this.caixa}) : super(key: key);

  @override
  _CaixaPDVPageState createState() => _CaixaPDVPageState(caixa: this.caixa);
}

class _CaixaPDVPageState extends State<CaixaPDVPage> with ValidadorPDV {
  _CaixaPDVPageState({this.caixa});

  var produtoController = GetIt.I.get<ProdutoController>();
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var focusScopeNode = FocusScopeNode();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  // var audioCache = AudioCache(prefix: "audios/");

  CaixaFluxo caixa;
  PedidoItem pedidoItem;
  Pedido pedido;
  Produto produto;
  Produto produtoSelecionado;
  var codigoBarraController = TextEditingController();
  var quantidadeController = TextEditingController();
  var valorUnitarioController = TextEditingController();
  var valorTotalController = TextEditingController();
  var descontoController = TextEditingController();
  var valorPedidoController = TextEditingController();
  var totalVolumesController = TextEditingController();
  var foto;
  String barcode = "";

  Controller controller;

  @override
  void initState() {
    // audioCache.loadAll(["beep-07.mp3"]);
    pedidoItemController.pedidosItens();
    if (produto == null) {
      produto = Produto();
      pedido = Pedido();
      pedidoItem = PedidoItem();
      quantidadeController.text = 1.toString();
      descontoController.text = 0.00.toString();
    }
    produtoController.getAll();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  executar(String nomeAudio) {
    // audioCache.play(nomeAudio + ".mp3");
  }

  buscarByCodigoDeBarraTeste(String codBarra) async {
    produto = await produtoController.getCodigoBarra(codBarra).then((value) {
      produto = value;
      if (produto == null) {
        showSnackbar(context, "Nenhum produto encontrado!");
      }
      return produto;
    });
  }

  barcodeScanning() async {
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

  showSnackbar(BuildContext context, String texto) {
    final snackbar = SnackBar(
      content: Text(texto),
    );
    GlobalScaffold.instance.showSnackbar(snackbar);
  }

  buscarByCodigoDeBarra(String codigoBarra) async {
    pedidoItem = PedidoItem();
    produto = await produtoController.getCodigoBarra(codigoBarra);

    if (produto != null) {
      setState(() {
        pedidoItem.valorUnitario = produto.estoque.valorUnitario;
        pedidoItem.quantidade = int.tryParse(quantidadeController.text);
        pedidoItem.valorTotal =
            (pedidoItem.quantidade * pedidoItem.valorUnitario);

        valorUnitarioController.text =
            pedidoItem.valorUnitario.toStringAsFixed(2);
        valorTotalController.text = pedidoItem.valorTotal.toStringAsFixed(2);

        pedidoItemController.calculateTotal();

        pedidoItemController.quantidade = pedidoItem.quantidade;

        print("Quantidade: ${pedidoItem.quantidade}");
        print("Valor unitário: ${pedidoItem.valorUnitario}");
        print("Valor total: ${pedidoItem.valorTotal}");
        print("Valor total: ${valorTotalController.text}");
        print("Descrição: ${produto.descricao}");
        adicionaItem(pedidoItem);
      });
    }
  }

  adicionaItem(PedidoItem pedidoItem) {
    setState(() {
      if (pedidoItemController.isExisteItem(new PedidoItem(produto: produto))) {
        pedidoItemController.remove(pedidoItem);
        pedidoItemController.itens;
        pedidoItemController.calculateTotal();
        showSnackbar(context, " removido");
      } else {
        pedidoItemController.adicionar(new PedidoItem(produto: produto));
        showSnackbar(context, "${produto.nome} adicionado");
        double total = pedidoItemController.total;
        valorPedidoController.text = total.toStringAsFixed(2);
        pedidoItemController.calculateTotal();
      }
    });
  }

  adicionaItemTeste(Produto p) {
    setState(() {
      if (pedidoItemController.isExisteItem(new PedidoItem(produto: p))) {
        pedidoItemController.remove(pedidoItem);
        pedidoItemController.itens;
        pedidoItemController.calculateTotal();

        showSnackbar(context, " removido");
        pedidoItemController.calculateTotal();
      } else {
        pedidoItemController.adicionar(new PedidoItem(produto: p));
        showSnackbar(context, "${produto.nome} adicionado");
        double total = pedidoItemController.total;
        valorPedidoController.text = total.toStringAsFixed(2);
        pedidoItemController.calculateTotal();
      }
    });
  }

  removeItem(PedidoItem pedidoItem) {
    setState(() {
      pedidoItemController.remove(pedidoItem);
      pedidoItemController.itens;
      showSnackbar(context, "item removido");
      pedidoItemController.calculateTotal();
    });
  }

  selecionaItem(PedidoItem p) {
    codigoBarraController.text = p.produto.codigoBarra;
    quantidadeController.text = p.quantidade.toStringAsFixed(0);
    valorUnitarioController.text = p.valorUnitario.toStringAsFixed(2);
    valorTotalController.text = p.valorTotal.toStringAsFixed(2);

    print("Código de barra: ${p.produto.codigoBarra}");
    print("Descrição: ${p.produto.descricao}");
    print("Quantidade: ${p.quantidade}");
    print("Valor unitário: ${p.valorUnitario}");
    print("Valor total: ${p.valorTotal}");

    print("Foto: ${p.produto.foto}");
  }

  limparEditorController() {
    codigoBarraController.clear();
    quantidadeController.clear();
    valorUnitarioController.clear();
    valorTotalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('dd-MM-yyyy HH:mm');

    valorPedidoController.text = pedidoItemController.total.toStringAsFixed(2);
    totalVolumesController.text = pedidoItemController.itens.length.toString();

    return Scaffold(
      key: GlobalScaffold.instance.scaffkey,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 50,
        title: Text("PDV2020"),
        actions: <Widget>[
          Container(
            height: 80,
            width: 250,
            padding: EdgeInsets.only(top: 0),
            child: Chip(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(1),
              shadowColor: Colors.grey[200],
              label: Text(
                "HORÁRIO: ${dateFormat.format(DateTime.now())}",
                style: TextStyle(
                  color: Colors.grey[100],
                ),
              ),
            ),
          ),
          Container(
            height: 80,
            width: 200,
            padding: EdgeInsets.only(top: 0),
            child: caixa == null
                ? Chip(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(1),
                    shadowColor: Colors.grey[200],
                    label: Text(
                      "CAIXA SEM STATUS",
                      style: TextStyle(
                        color: Colors.grey[100],
                      ),
                    ),
                  )
                : Chip(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(1),
                    shadowColor: Colors.grey[200],
                    label: Text(
                      "CAIXA ESTÁ ${caixa.caixaStatus}",
                      style: TextStyle(
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
          ),
          Container(
            height: 80,
            width: 200,
            padding: EdgeInsets.only(top: 0),
            child: caixa != null
                ? Chip(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(1),
                    shadowColor: Colors.grey[100],
                    label: Text(
                      "${caixa.caixa.referencia} - ${caixa.descricao}",
                      style: TextStyle(
                        color: Colors.grey[100],
                      ),
                    ),
                  )
                : Chip(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(1),
                    shadowColor: Colors.grey[200],
                    label: Text(
                      "CAIXA SEM REFERENCIA",
                      style: TextStyle(
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
          ),
          Observer(
            builder: (context) {
              if (pedidoItemController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (pedidoItemController.itens == null) {
                return CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  foregroundColor: Colors.grey[200],
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                foregroundColor: Colors.grey[200],
                child: Text(
                  (pedidoItemController.itens.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.grey[200],
            child: IconButton(
              icon: Icon(Icons.refresh_rounded),
              onPressed: () {
                setState(() {
                  print("itens: ${pedidoItemController.itens.length}");
                  pedidoItemController.pedidosItens();
                });
              },
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.grey[200],
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ItemPage();
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            foregroundColor: Colors.grey[200],
            child: IconButton(
              icon: Icon(Icons.shopping_basket_outlined),
              onPressed: () {
                buildShowDialogProduto(context);
              },
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.only(left: 100, right: 100, top: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 10,
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              padding: EdgeInsets.all(0),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 450,
                    height: 600,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 500,
                          color: Theme.of(context).primaryColor.withOpacity(1),
                          // padding: EdgeInsets.only(top: 10),
                          child: buildForm(dateFormat, context),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          height: 100,
                          color: Theme.of(context).accentColor.withOpacity(1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 200,
                                child: ListTile(
                                  title: Text(
                                    "DESCONTO",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: TextFormField(
                                    controller: descontoController,
                                    validator: validateDesconto,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 2),
                                      ),
                                      hintStyle: TextStyle(color: Colors.white),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            descontoController.clear(),
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              Container(
                                width: 200,
                                child: ListTile(
                                  title: Text(
                                    "VALOR TOTAL",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: TextFormField(
                                    controller: valorPedidoController,
                                    validator: validateValorTotal,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25),
                                    decoration: InputDecoration(
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 2),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            valorPedidoController.clear(),
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    enabled: false,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 600,
                      color: Colors.grey[100],
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 500,
                            color: Colors.grey[100],
                            child: builderConteudoList(),
                          ),
                          Container(
                            width: double.infinity,
                            height: 100,
                            color:
                                Theme.of(context).primaryColor.withOpacity(1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FlatButton.icon(
                                    label: Text(
                                      "CANCELAR COMPRAR",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    icon: Icon(Icons.cancel_outlined),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      side: BorderSide(
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    color: Colors.white,
                                    textColor: Theme.of(context).accentColor,
                                    padding: EdgeInsets.only(
                                        left: 40,
                                        right: 40,
                                        top: 25,
                                        bottom: 25),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PedidoPage(),
                                        ),
                                      );
                                    }),
                                FlatButton.icon(
                                  label: Text(
                                    "FECHAR VENDA",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.shopping_basket_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    side: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  color: Colors.white,
                                  textColor: Colors.green,
                                  padding: EdgeInsets.only(
                                      left: 40, right: 40, top: 25, bottom: 25),
                                  onPressed: () {
                                    if (controller.validate()) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PedidoCreatePage(
                                            pedidoItem: pedidoItem,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              padding: EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialogProduto(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Produtos"),
          content: Container(
            height: 100,
            width: 300,
            child: builderConteudoListProdutos(),
          ),
          actions: [
            FlatButton(
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("CANCELAR"),
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  adicionaItemTeste(produtoSelecionado);
                });
                Navigator.of(context).pop();
              },
              child: Text("CONFIRMAR"),
            ),
          ],
        );
      },
    );
  }

  buildForm(DateFormat dateFormat, BuildContext context) {
    // var focus = FocusScope.of(context);
    return Form(
      key: controller.formKey,
      child: ListView(
        children: [
          SizedBox(height: 20),
          Container(
            child: ListTile(
              title: Text(
                "CÓDIGO DE BARRA",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: TextFormField(
                controller: codigoBarraController,
                validator: validateCodigoBarra,
                onChanged: (valor) {
                  setState(() {
                    buscarByCodigoDeBarra(codigoBarraController.text);
                  });
                },
                style: TextStyle(color: Colors.black, fontSize: 25),
                decoration: InputDecoration(
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => codigoBarraController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
                // onEditingComplete: () => focus.nextFocus(),
                keyboardType: TextInputType.number,
                maxLength: 20,
              ),
            ),
          ),
          Container(
            child: ListTile(
              title: Text(
                "QUANTIDADE",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: TextFormField(
                controller: quantidadeController,
                validator: validateQuantidade,
                style: TextStyle(color: Colors.black, fontSize: 25),
                decoration: InputDecoration(
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => quantidadeController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
                // onEditingComplete: () => focus.nextFocus(),
                keyboardType: TextInputType.number,
                maxLength: 20,
              ),
            ),
          ),
          Container(
            child: ListTile(
              title: Text(
                "VALOR UNITÁRIO",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: TextFormField(
                controller: valorUnitarioController,
                validator: validateValorUnitario,
                style: TextStyle(color: Colors.black, fontSize: 25),
                decoration: InputDecoration(
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => valorUnitarioController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
                // onEditingComplete: () => focus.nextFocus(),
                keyboardType: TextInputType.number,
                maxLength: 20,
              ),
            ),
          ),
          Container(
            child: ListTile(
              title: Text(
                "SUBTOTAL",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: TextFormField(
                controller: valorTotalController,
                validator: validateSubTotal,
                style: TextStyle(color: Colors.black, fontSize: 25),
                decoration: InputDecoration(
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => valorTotalController.clear(),
                    icon: Icon(Icons.clear),
                  ),
                ),
                // onEditingComplete: () => focus.nextFocus(),
                keyboardType: TextInputType.number,
                maxLength: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildPush(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PedidoCreatePage(),
      ),
    );
  }

  builderConteudoList() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<PedidoItem> itens = pedidoItemController.itens;
          if (pedidoItemController.error != null) {
            return Text("Não foi possível carregados dados");
          }

          if (itens == null) {
            return CircularProgressor();
          }

          if (itens.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Icon(
                      Icons.shopping_basket,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                  Text("Sua cesta está vazia"),
                ],
              ),
            );
          }
          return builderTable(itens);
        },
      ),
    );
  }

  buildTable(List<PedidoItem> itens) {
    return ListView(
      children: [
        PaginatedDataTable(
          rowsPerPage: 8,
          showCheckboxColumn: true,
          sortColumnIndex: 1,
          sortAscending: true,
          showFirstLastButtons: true,
          columnSpacing: 10,
          columns: [
            DataColumn(label: Text("Cód")),
            DataColumn(label: Text("Foto")),
            DataColumn(label: Text("Quant.")),
            DataColumn(label: Text("Unit.")),
            DataColumn(label: Text("Descrição")),
            DataColumn(label: Text("Total")),
            DataColumn(label: Text("Excluir"))
          ],
          source: DataSource(itens, context),
        ),
      ],
    );
  }

  builderTable(List<PedidoItem> itens) {
    return DataTable(
      columnSpacing: 6,
      showCheckboxColumn: false,
      sortAscending: true,
      dataTextStyle: TextStyle(color: Colors.grey[700]),
      columns: [
        DataColumn(label: Text("Cód")),
        DataColumn(label: Text("Foto")),
        DataColumn(label: Text("Quant.")),
        DataColumn(label: Text("Unit.")),
        DataColumn(label: Text("Descrição")),
        DataColumn(label: Text("Total")),
        DataColumn(label: Text("Excluir"))
      ],
      rows: itens
          .map(
            (p) => DataRow(
              selected: false,
              onSelectChanged: (i) {
                setState(() {
                  selecionaItem(p);
                });
              },
              cells: [
                DataCell(Text("${p.produto.id}")),
                DataCell(
                  p.produto.foto != null
                      ? CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          radius: 20,
                          backgroundImage: NetworkImage(
                              "${produtoController.arquivo + p.produto.foto}"),
                        )
                      : CircleAvatar(
                          child: Image.asset(ConstantApi.urlLogo),
                          radius: 20,
                        ),
                ),
                DataCell(Text("${p.quantidade}")),
                DataCell(
                  Text(
                    "R\$ ${formatMoeda.format(p.valorUnitario)}",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                DataCell(Text(p.produto.nome)),
                DataCell(
                  Text(
                    "R\$ ${formatMoeda.format(p.valorTotal)}",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                DataCell(
                  CircleAvatar(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.4),
                    child: IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () {
                        showDialogAlertExcluir(context, p);
                      },
                    ),
                  ),
                )
              ],
            ),
          )
          .toList(),
    );
  }

  builderConteudoListProdutos() {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: Observer(
        builder: (context) {
          List<Produto> produtos = produtoController.produtos;
          if (produtoController.error != null) {
            return Text("Não foi possível buscar produtos");
          }

          if (produtos == null) {
            return CircularProgressorMini();
          }

          return DropdownSearch<Produto>(
            label: "Selecione produtos",
            popupTitle: Center(child: Text("Produtos")),
            items: produtos,
            showSearchBox: true,
            itemAsString: (Produto s) => s.nome,
            validator: (s) => s == null ? "campo obrigatório" : null,
            isFilteredOnline: true,
            showClearButton: true,
            selectedItem: produtoSelecionado,
            onChanged: (Produto s) {
              setState(() {
                produtoSelecionado = s;
                print("Produto: ${produtoSelecionado.nome}");
              });
            },
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelText: "Pesquisar por seguimento",
            ),
          );
        },
      ),
    );
  }

  showDialogAlertExcluir(BuildContext context, PedidoItem p) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Deseja remover este item?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${p.produto.nome}"),
                Text("Cod: ${p.produto.id}"),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: p.produto.foto != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            produtoController.arquivo + p.produto.foto,
                            fit: BoxFit.cover,
                            width: 250,
                            height: 230,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            ConstantApi.urlLogo,
                            fit: BoxFit.cover,
                            width: 250,
                            height: 230,
                          ),
                        ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton.icon(
              icon: Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).accentColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
              label: Text('CANCELAR'),
              color: Colors.white,
              elevation: 0,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton.icon(
              icon: Icon(
                Icons.restore_from_trash,
                color: Theme.of(context).primaryColor,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
              label: Text('EXCLUIR'),
              color: Colors.white,
              elevation: 0,
              onPressed: () {
                setState(() {
                  pedidoItemController.remove(p);
                  pedidoItemController.calculateTotal();
                  pedidoItemController.itens;
                  limparEditorController();
                });

                showSnackbar(context, "Produto ${p.produto.nome} removido");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showDialogAlertCancelar(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.all(10),
          title: Text(
            "Deseja cancelar esta venda?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Container(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.mood_bad_outlined,
                    size: 100,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton.icon(
              icon: Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
              ),
              label: Text('NÃO'),
              color: Colors.white,
              elevation: 0,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton.icon(
              icon: Icon(
                Icons.restore_from_trash,
                color: Theme.of(context).primaryColor,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              label: Text('SIM'),
              color: Colors.white,
              elevation: 0,
              onPressed: () {
                setState(() {
                  pedidoItemController.itens.clear();
                  pedidoItemController.itens;
                  valorPedidoController.clear();
                  pedidoItem = new PedidoItem(produto: new Produto());
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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

class DataSource extends DataTableSource {
  var pedidoController = GetIt.I.get<PedidoController>();
  var produtoController = GetIt.I.get<ProdutoController>();

  BuildContext context;
  List<PedidoItem> itens;
  int selectedCount = 0;
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  DataSource(this.itens, this.context);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= itens.length) return null;
    PedidoItem p = itens[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text("${p.produto.id}")),
        DataCell(
          p.produto.foto != null
              ? CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: 20,
                  backgroundImage: NetworkImage(
                      "${produtoController.arquivo + p.produto.foto}"),
                )
              : CircleAvatar(
                  radius: 20,
                ),
        ),
        DataCell(Text("${p.quantidade}")),
        DataCell(
          Text(
            "R\$ ${formatMoeda.format(p.valorUnitario)}",
            style: TextStyle(color: Colors.red),
          ),
        ),
        DataCell(Text(p.produto.nome)),
        DataCell(
          Text(
            "R\$ ${formatMoeda.format(p.valorTotal)}",
            style: TextStyle(color: Colors.red),
          ),
        ),
        DataCell(
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              // showDialogAlertExcluir(context, p);
            },
          ),
        )
      ],
    );
  }

  @override
  int get rowCount => itens.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => selectedCount;
}
