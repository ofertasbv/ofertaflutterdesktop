import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:intl/intl.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/core/model/pedidoitem.dart';
import 'package:nosso/src/paginas/pedido/pedido_create_page.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/util/load/circular_progresso.dart';
import 'package:nosso/src/util/snackbar/snackbar_global.dart';

class PedidoItensListPage extends StatefulWidget {
  @override
  _PedidoItensListPageState createState() => _PedidoItensListPageState();
}

class _PedidoItensListPageState extends State<PedidoItensListPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus pedidos"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Container(
          child: builderConteudoList(),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
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
                  SizedBox(height: 20),
                  RaisedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProdutoPage();
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
    double containerHeight = 50;

    return ListView.builder(
      itemCount: itens.length,
      itemBuilder: (context, index) {
        PedidoItem p = itens[index];

        return GestureDetector(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Card(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        p.produto.foto != null
                            ? Container(
                                color: Colors.grey[500],
                                child: Image.network(
                                  ConstantApi.urlArquivoProduto +
                                      p.produto.foto,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                ),
                              )
                            : Container(
                                color: Colors.grey[500],
                                child: Image.asset(
                                  ConstantApi.urlLogo,
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 100,
                                color: Colors.grey[200],
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text(
                                    p.produto.nome,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${p.produto.descricao}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: CircleAvatar(
                                    child: Icon(Icons.favorite_border_outlined),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 100,
                                color: Colors.grey[200],
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text(
                                    p.produto.loja.nome,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${p.produto.promocao.nome}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: CircleAvatar(
                                    backgroundColor: Colors.grey[300],
                                    child: Icon(Icons.location_on_outlined),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey[100],
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: containerHeight,
                                width: containerWidth,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Valor unitário ",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "R\$ ${formatMoeda.format(p.valorUnitario)}",
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                height: containerHeight,
                                width: containerWidth,
                                //color: Colors.grey[300],
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "SubTotal ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "R\$ ${formatMoeda.format(p.valorTotal)}",
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: containerWidth,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                      height: 50,
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
                                                    pedidoItemController
                                                        .decremento(p);
                                                    pedidoItemController
                                                        .calculateTotal();
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
                                                    pedidoItemController
                                                        .incremento(p);
                                                    pedidoItemController
                                                        .calculateTotal();
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
                          ),
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

  buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ListTile(
                title: Text(
                  "TOTAL ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: Observer(
                  builder: (context) {
                    return Text(
                      "R\$ ${formatMoeda.format(pedidoItemController.total)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).accentColor,
                      ),
                    );
                  },
                ),
                trailing: Text(
                  "No boleto ou dinheiro",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FlatButton.icon(
                      icon: Icon(Icons.list_alt),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(color: Colors.blue),
                      ),
                      color: Colors.white,
                      textColor: Colors.blue,
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ProdutoPage();
                            },
                          ),
                        );
                      },
                      label: Text(
                        "VER MAIS".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FlatButton.icon(
                      icon: Icon(Icons.shopping_basket),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(color: Colors.green),
                      ),
                      color: Colors.white,
                      textColor: Colors.green,
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        if (pedidoItemController.itens.isEmpty) {
                          print("seu carrinho está vazio!");
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return PedidoCreatePage();
                              },
                            ),
                          );
                        }
                      },
                      label: Text(
                        "CONTINUAR PEDIDO".toUpperCase(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${p.produto.nome}"),
                Text("Cod: ${p.produto.id}"),
                SizedBox(height: 20),
                Center(
                  child: p.produto.foto != null
                      ? Container(
                          child: Image.network(
                            ConstantApi.urlArquivoProduto + p.produto.foto,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        )
                      : Container(
                          width: 200,
                          height: 200,
                          color: Colors.grey[500],
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
                  pedidoItemController.calculateTotal();
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
