import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/controller/produto_controller.dart';
import 'package:nosso/src/core/model/caixa.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/core/model/produto.dart';
import 'package:nosso/src/paginas/pedidoitem/itens_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/snackbar/snackbar_global.dart';
import 'package:nosso/src/util/validador/validador_pdv.dart';

class CaixaPDVPage extends StatefulWidget {
  Caixa caixa;

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
  var audioCache = AudioCache(prefix: "audios/");

  String barcode = "";
  Produto p;
  PedidoItem pedidoItem;
  var codigoBarraController = TextEditingController();
  var quantidadeController = TextEditingController();
  var valorUnitarioController = TextEditingController();
  var valorTotalController = TextEditingController();
  var descontoController = TextEditingController();
  var valorPedidoController = TextEditingController();
  var totalVolumesController = TextEditingController();
  var foto;

  Caixa caixa;
  Controller controller;

  @override
  void initState() {
    audioCache.loadAll(["beep-07.mp3"]);
    pedidoItemController.pedidosItens();
    if (p == null) {
      p = Produto();
      pedidoItem = PedidoItem();
      quantidadeController.text = 1.toString();
    }
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
    audioCache.play(nomeAudio + ".mp3");
  }

  buscarByCodigoDeBarraTeste(String codBarra) async {
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

  showSnackbar(BuildContext context, String texto) {
    final snackbar = SnackBar(content: Text(texto));
    GlobalScaffold.instance.showSnackbar(snackbar);
  }

  buscarByCodigoDeBarra(String codigoBarra) async {
    p = await produtoController.getCodigoBarra(codigoBarra);

    if (p != null) {
      setState(() {
        pedidoItem.valorUnitario = p.estoque.valorUnitario;
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
        print("Descrição: ${p.descricao}");
      });
    }
  }

  adicionaItem(PedidoItem pedidoItem) {
    setState(() {
      if (pedidoItemController.isExisteItem(new PedidoItem(produto: p))) {
        pedidoItemController.remove(pedidoItem);
        pedidoItemController.itens;
        // pedidoItemController.adicionar(new PedidoItem(produto: p));

        showSnackbar(context, " removido");
        pedidoItemController.calculateTotal();
      } else {
        pedidoItemController.adicionar(new PedidoItem(produto: p));
        showSnackbar(context, "${p.nome} adicionado");
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

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat('dd-MM-yyyy HH:mm');

    valorPedidoController.text = pedidoItemController.total.toStringAsFixed(2);
    totalVolumesController.text = pedidoItemController.itens.length.toString();

    return Scaffold(
      key: GlobalScaffold.instance.scaffkey,
      appBar: AppBar(
        title: Text("PDV2020"),
        actions: <Widget>[
          Observer(
            builder: (context) {
              if (pedidoItemController.error != null) {
                return Text("Não foi possível carregar");
              }

              if (pedidoItemController.itens == null) {
                return Center(
                  child: Icon(Icons.warning_amber_outlined),
                );
              }

              return Chip(
                label: Text(
                  (pedidoItemController.itens.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 2),
          IconButton(
            icon: Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {
                print("itens: ${pedidoItemController.itens.length}");
                pedidoItemController.pedidosItens();
              });
            },
          ),
          SizedBox(width: 2),
          IconButton(
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
          SizedBox(width: 2),
          IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            onPressed: () {
              barcodeScanning();
            },
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Observer(
        builder: (context) {
          if (pedidoItemController.dioError == null) {
            return buildForm(dateFormat, context);
          } else {
            print("Erro: ${pedidoItemController.mensagem}");
            return buildForm(dateFormat, context);
          }
        },
      ),
    );
  }

  Form buildForm(DateFormat dateFormat, BuildContext context) {
    return Form(
      key: controller.formKey,
      child: ListView(
        children: [
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            padding: EdgeInsets.all(0),
            child: ListTile(
              title: caixa == null
                  ? Text("CAIXA SEM STATUS")
                  : Text("CAIXA ESTÁ ${caixa.caixaStatus}"),
              subtitle: caixa == null
                  ? Text("CAIXA SEM REFERENCIA")
                  : Text("${caixa.descricao} - ${caixa.referencia}"),
              trailing: Text("${dateFormat.format(DateTime.now())}"),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CÓDIGO DE BARRA",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: codigoBarraController,
                  validator: validateCodigoBarra,
                  onFieldSubmitted: (valor) {
                    if (controller.validate()) {
                      setState(() {
                        codigoBarraController.text = valor;
                        buscarByCodigoDeBarra(codigoBarraController.text);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => codigoBarraController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                ),
                SizedBox(height: 5),
                Text(
                  "QUANTIDADE",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: quantidadeController,
                  validator: validateQuantidade,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => quantidadeController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                ),
                SizedBox(height: 5),
                Text(
                  "VALOR UNITÁRIO",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: valorUnitarioController,
                  validator: validateValorUnitario,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => valorUnitarioController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 13,
                ),
                SizedBox(height: 5),
                Text(
                  "SUBTOTAL",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: valorTotalController,
                  validator: validateValorTotal,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => valorTotalController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                ),
                SizedBox(height: 5),
                Text(
                  "DESCONTO",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: descontoController,
                  validator: validateDesconto,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () => descontoController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lime[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                Text(
                  "VALOR TOTAL",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: valorPedidoController,
                  validator: validateValorTotal,
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () => valorPedidoController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lime[900]),
                      gapPadding: 1,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: RaisedButton.icon(
              label: Text("Enviar formulário"),
              icon: Icon(Icons.check),
              onPressed: () {
                if (controller.validate()) {}
              },
            ),
          ),
        ],
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

  builderTable(List<PedidoItem> itens) {
    return DataTable(
      sortAscending: true,
      showCheckboxColumn: true,
      showBottomBorder: true,
      columns: [
        DataColumn(label: Text("Código")),
        DataColumn(label: Text("Quantidade")),
        DataColumn(label: Text("Valor Unit.")),
        DataColumn(label: Text("Descrição")),
        DataColumn(label: Text("Valor Total")),
        DataColumn(label: Text("Excluir"))
      ],
      rows: itens
          .map(
            (p) => DataRow(
              onSelectChanged: (i) {
                setState(() {
                  selecionaItem(p);
                });
              },
              cells: [
                DataCell(
                  Text("${p.produto.id}"),
                ),
                DataCell(
                  Text("${p.quantidade}"),
                ),
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
                      showDialogAlertExcluir(context, p);
                    },
                  ),
                )
              ],
            ),
          )
          .toList(),
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
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${p.produto.nome}"),
                Text("Cod: ${p.produto.id}"),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ConstantApi.urlArquivoProduto + p.produto.foto,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
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
                side: BorderSide(color: Colors.grey),
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
                color: Colors.green,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green),
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
                  pedidoItemController.itens;
                });

                // showSnackbar(context, "Produto ${p.produto.nome} removido");
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
                side: BorderSide(color: Colors.grey),
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
                color: Colors.green,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.all(
                  Radius.circular(0),
                ),
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

                // showSnackbar(context, "Produto ${p.produto.nome} removido");
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
