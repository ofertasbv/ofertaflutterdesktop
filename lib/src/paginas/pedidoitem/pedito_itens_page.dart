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
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
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
        titleSpacing: 50,
        title: Text("Meus pedidos"),
        actions: [
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

              return CircleAvatar(
                foregroundColor: Colors.grey[100],
                child: Text(
                  (pedidoItemController.itens.length ?? 0).toString(),
                ),
              );
            },
          ),
          SizedBox(width: 5),
          CircleAvatar(
            foregroundColor: Theme.of(context).accentColor,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.grey[100],
              ),
              onPressed: () {
                pedidoItemController.getAll();
              },
            ),
          ),
          SizedBox(width: 50)
        ],
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
            return CircularProgressorMini();
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
                      borderRadius: BorderRadius.circular(10),
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
    double containerWidth = 100;
    double containerHeight = 50;

    return ListView.builder(
      itemCount: itens.length,
      itemBuilder: (context, index) {
        PedidoItem p = itens[index];

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[100],
                    ),
                    padding: EdgeInsets.all(0),
                    child: p.produto.foto != null
                        ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[300],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                "${ConstantApi.urlArquivoProduto + p.produto.foto}",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200],
                            ),
                            child: Icon(
                              Icons.photo,
                              size: 50,
                            ),
                          ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        p.produto.nome,
                      ),
                      subtitle: Text(
                        "R\$ ${formatMoeda.format(p.valorTotal)}",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 100,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                          child: IconButton(
                            icon: Icon(Icons.add),
                            splashColor: Colors.black,
                            onPressed: () {
                              setState(() {
                                pedidoItemController.incremento(p);
                                pedidoItemController.calculateTotal();
                              });
                            },
                          ),
                        ),
                        Text("${p.quantidade}"),
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                          child: IconButton(
                            icon: Icon(Icons.indeterminate_check_box_outlined),
                            splashColor: Colors.black,
                            onPressed: () {
                              setState(() {
                                pedidoItemController.decremento(p);
                                pedidoItemController.calculateTotal();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          onDoubleTap: () {
            showDialogAlert(context, p);
          },
        );
      },
    );
  }

  buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, top: 0, bottom: 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
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
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: Observer(
                  builder: (context) {
                    return Text(
                      "R\$ ${formatMoeda.format(pedidoItemController.total)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                        side: BorderSide(color: Colors.transparent),
                      ),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
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
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FlatButton.icon(
                      icon: Icon(Icons.shopping_basket),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(color: Colors.transparent),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
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
                        "CONTINUAR".toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
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
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
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
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                          child: Icon(
                            Icons.photo,
                            size: 50,
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
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              label: Text('CANCELAR'),
              color: Theme.of(context).accentColor,
              elevation: 0,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton.icon(
              icon: Icon(
                Icons.restore_from_trash,
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              label: Text('EXCLUIR'),
              color: Theme.of(context).primaryColor,
              elevation: 0,
              onPressed: () {
                setState(() {
                  pedidoItemController.remove(p);
                  pedidoItemController.itens;
                  pedidoItemController.calculateTotal();
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
}
