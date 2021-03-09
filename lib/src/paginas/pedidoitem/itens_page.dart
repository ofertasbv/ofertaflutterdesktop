import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nosso/src/core/controller/pedidoItem_controller.dart';
import 'package:nosso/src/paginas/pedido/pedido_create_page.dart';
import 'package:nosso/src/paginas/pedidoitem/pedito_itens_page.dart';
import 'package:nosso/src/paginas/produto/produto_tab.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  var pedidoItemController = GetIt.I.get<PedidoItemController>();
  var formatMoeda = new NumberFormat("#,##0.00", "pt_BR");

  showToast(String cardTitle) {
    Fluttertoast.showToast(
      msg: "$cardTitle",
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 20,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Itens pedido"),
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
          SizedBox(width: 20),
        ],
      ),
      body: PedidoItensList(),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  buildBottomNavigationBar(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: Column(
        children: [
          Container(
            color: Colors.grey[100],
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ListTile(
              title: Text(
                "TOTAL ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "R\$ ${formatMoeda.format(pedidoItemController.total)}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
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
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
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
                            return ProdutoTab();
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
                  flex: 3,
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
                        showToast("seu carrinho está vazio!");
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
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
