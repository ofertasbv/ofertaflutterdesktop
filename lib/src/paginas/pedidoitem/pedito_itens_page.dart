import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/snackbar/snackbar_global.dart';

class PedidoItensList extends StatefulWidget {
  @override
  _PedidoItensListState createState() => _PedidoItensListState();
}

class _PedidoItensListState extends State<PedidoItensList> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  @override
  void initState() {
    pedidoItemController.pedidosItens();
    pedidoItemController.calculateTotal();
    super.initState();
  }

  showSnackbar(BuildContext context, String texto) {
    final snackbar = SnackBar(content: Text(texto));
    GlobalScaffold.instance.showSnackbar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return builderConteudoList();
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
                  SizedBox(height: 20),
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProdutoTab();
                          },
                        ),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(color: Colors.blue),
                    ),
                    color: Colors.white,
                    textColor: Colors.green,
                    padding: EdgeInsets.all(10),
                    icon: Icon(
                      Icons.home,
                      color: Colors.blue,
                    ),
                    label: Text(
                      "ESCOLHER PRODUTOS",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    elevation: 0,
                  ),
                ],
              ),
            );
          }

          return builderList(itens);
        },
      ),
    );
  }

  ListView builderList(List<PedidoItem> itens) {
    double containerWidth = 300;
    double containerHeight = 20;

    return ListView.builder(
      itemCount: itens.length,
      itemBuilder: (context, index) {
        PedidoItem p = itens[index];
        p.valorUnitario = p.produto.estoque.valorUnitario;
        p.valorTotal = (p.quantidade * p.valorUnitario);

        return GestureDetector(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Card(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        p.produto.foto != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  ConstantApi.urlArquivoProduto +
                                      p.produto.foto,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 130,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  ConstantApi.urlLogo,
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 130,
                                ),
                              ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 30,
                              width: containerWidth,
                              child: Text(
                                p.produto.nome,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: containerHeight,
                              width: containerWidth,
                              //color: Colors.grey[300],
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Valor unitário ",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "R\$ ${formatMoeda.format(p.valorUnitario)}",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: containerHeight,
                              width: containerWidth,
                              //color: Colors.grey[300],
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "SubTotal ",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "R\$ ${formatMoeda.format(p.valorTotal)}",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: containerWidth,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.grey[200],
                                    foregroundColor: Colors.redAccent,
                                    radius: 20,
                                    child: IconButton(
                                      icon: Icon(Icons.delete_forever),
                                      splashColor: Colors.black,
                                      onPressed: () {
                                        showDialogAlert(context, p);
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      color: Colors.grey[300],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        SizedBox(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[200],
                                            foregroundColor: Colors.black,
                                            child: IconButton(
                                              icon: Icon(Icons
                                                  .indeterminate_check_box_outlined),
                                              splashColor: Colors.black,
                                              onPressed: () {
                                                setState(() {
                                                  print("removendo - ");
                                                  print(
                                                      "Quantidade: ${p.quantidade}");
                                                  pedidoItemController
                                                      .decremento(p);
                                                  pedidoItemController
                                                      .calculateTotal();
                                                  print(
                                                      "Total: ${pedidoItemController.total}");
                                                  pedidoItemController.itens;
                                                });
                                              },
                                            ),
                                          ),
                                          width: 38,
                                        ),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          color: Colors.grey[100],
                                          child: Center(
                                            child: Text(
                                              "${p.quantidade}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[200],
                                            foregroundColor: Colors.black,
                                            child: IconButton(
                                              icon: Icon(Icons.add),
                                              splashColor: Colors.black,
                                              onPressed: () {
                                                setState(() {
                                                  print("adicionando + ");
                                                  print(
                                                      "Quantidade: ${p.quantidade}");
                                                  pedidoItemController
                                                      .incremento(p);
                                                  pedidoItemController
                                                      .calculateTotal();
                                                  print(
                                                      "Total: ${pedidoItemController.total}");
                                                  pedidoItemController.itens;
                                                });
                                              },
                                            ),
                                          ),
                                          width: 38,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showDialogAlert(BuildContext context, PedidoItem p) async {
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
}
